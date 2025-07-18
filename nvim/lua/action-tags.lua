
-- local prefix = {
--     [""]
-- }

local function starts(s, pre)
   return string.sub(s,1,string.len(pre))==pre
end

local function get_line_tags(line)
    local tag_regex = vim.regex("\\[[^]]*\\]") -- .* is too greedy

    local l = {}
    while tag_regex:match_str(line) do
        local s, e = tag_regex:match_str(line)

        -- need to split on first ':' here
        local action, action_body = unpack(vim.split(string.sub(line, s+2, e-1), ':'))
        if not l[action] then
            l[action] = {}
        end

        l[action][#l[action]] = action_body

        line = string.sub(line, e)
    end
    return l
end

local function parse_md_note()
    local top_row, col = unpack(vim.api.nvim_win_get_cursor(0))
    top_row = top_row - 1 -- actually set it to the line you're at
    top_row = top_row + 1 -- then skip the hashtag

    local line = vim.api.nvim_buf_get_lines(0, top_row, top_row+1, {})[1]
    -- print(line)

    while not starts(line, '# ') and top_row > 0 do
        top_row = top_row - 1
        line = vim.api.nvim_buf_get_lines(0, top_row, top_row+1, {})[1]
    end


    -- hashtag then EOF
    local bot_row = top_row + 1
    local line = vim.api.nvim_buf_get_lines(0, bot_row, bot_row+1, {})[1]

    local line_count = vim.api.nvim_buf_line_count(0)

    while not starts(line, '# ') and bot_row+1 < line_count do
        bot_row = bot_row + 1
        line = vim.api.nvim_buf_get_lines(0, bot_row, bot_row+1, {})[1]
    end

    local line2 = vim.api.nvim_buf_get_lines(0, top_row+1, top_row+2, {})[1]

    local t = {
        ["tags"] = get_line_tags(line2),
        ["header"] = vim.api.nvim_buf_get_lines(0, top_row, top_row+1, {})[1],
        ["body"] = vim.api.nvim_buf_get_lines(0, top_row+2, bot_row, {})
    }

    return t
end

-- spec for actions:
-- self
-- header
-- list of all tags (including self)
-- file body

local action_tags = {
    ["git"] = function(self_body, header, tags, note_body)
        if not tags["file"] then
            return
        end

        local file = tags["file"][0]
        local cwd = vim.uv.cwd()
        vim.uv.chdir(file)

        vim.system(
            {
                "git", "switch", self_body
            },
            { text = true,
            cwd = tags["file"][0]
        },
            function(res)
                print(res.stderr)
            end
        )
        vim.uv.chdir(cwd)
    end
}

function interpolate(template, vars)
  return (template:gsub("%%{(.-)}", function(key)
    return tostring(vars[key] or "<undefined>")
  end))
end


local float = require("plenary.window.float")
local popup = require("plenary.popup")

-- local result = interpolate({
--   name = "Alice",
--   score = 93,
--   total = 100,
-- })

local function mk_capture_template(opts)
    return function()
        local s = opts.template
        local vars = opts.vars ()
        local res = interpolate(s, vars)

        local lines = {}
        for line in res:gmatch("[^\r\n]+") do
          table.insert(lines, line)
        end

        local bufnr = vim.api.nvim_create_buf(false, true) -- [listed = false, scratch = true]
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, lines)
        vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr})

        local win_id = popup.create(bufnr, {
          title = "Template Output",
          highlight = "Normal",
          line = math.floor((vim.o.lines - 10) / 2),
          col = math.floor((vim.o.columns - 60) / 2),
          minwidth = 60,
          minheight = 10,
          border = true,
        })



      vim.api.nvim_create_autocmd(
          "QuitPre", {
          -- "WinClosed", {
          buffer = bufnr,
          callback = function() 
            lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, {})

            local drawer = vim.api.nvim_create_buf(false, false)
            vim.api.nvim_buf_call(drawer,
            function()
                vim.cmd "e ~/.drawer"
                vim.api.nvim_buf_set_lines(drawer, -1, -1, false, lines)
                vim.cmd "w"
            end)
            vim.api.nvim_buf_delete(drawer, {})

          end

          }
      )

        vim.cmd("normal! G$")
        vim.cmd("startinsert")

        end
end

local docstring = [[
# gh issue
[file:%{file}] [git:%{branch}]
]]
 
local git_capture = {
    template = docstring,
    vars = function()
        return {
            file = "aaa",
            branch = "www",
        }
    end
}

local function open_drawer()
        local drawer = vim.api.nvim_create_buf(false, false) -- [listed = false, scratch = true]
        vim.api.nvim_set_current_buf(drawer)
        vim.cmd "e ~/.drawer"
end

-- local function search_tag(tag)
--     require("telescope.builtin").grep_string {}
--     vim.api.nvim_feedkeys("1234", 'i', false)
-- end

vim.api.nvim_create_user_command("Drawer", open_drawer, {})
-- vim.api.nvim_create_user_command("STag", search_tag, {})

vim.api.nvim_create_user_command("Cap", mk_capture_template(git_capture), {})


-- local popup = require("plenary.popup")

-- function open_capture()
-- end

-- Write up capture templates



vim.api.nvim_create_user_command("Action",function()
      res = parse_md_note()
      for tag, bodies in pairs(res.tags) do
          for _, body in pairs(bodies) do
              if tag and body and action_tags[tag] then
                  action_tags[tag](body, res.header, res.tags, res.body)
              end

          end
      end
end,{})

