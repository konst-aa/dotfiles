vim.g.easy_align_delimiters = {
    [":"]={
        pattern = ":",
        delimiter_align = "l",
        ignore_groups = {"!Comment"},
    },
    ["$"]={
        pattern="\\$",
        right_margin=0,
        left_margin=2
        -- delimiter_align = "l",
        -- ignore_groups = {"!Comment"},
    },
    ["#"]={
        ["pattern"]="\\#",
        ["right_margin"]=1,
        ignore_groups = {},
        left_margin='  ',
    }
}
