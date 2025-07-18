#!/usr/bin/env bash

declare -a workspace_map=(
    ["1"]="Brave"
    ["2"]="kitty /Applications/kitty.app"
    ["3"]="Code"
    ["4"]="Slack /Applications/Slack.app"
    # ["4"]="Discord /Applications/Discord.app"
    ["5"]="Spotify /Applications/Spotify.app"
)


function setup() {
    space=$1

    if [[ -n "${workspace_map[$space]}" ]]; then
        temp=(${workspace_map[$space]})


        target=${temp[0]}

        # spaces case ah
        if [[ $space == '1' ]]; then
            target='Brave Browser'
        fi
        app_path=${temp[1]}

        matching_windows="$(aerospace list-windows --workspace $space --json \
            | jq -r ".[] | select(.\"app-name\" == \"${target}\")")"


        if [[ -z $matching_windows ]]; then
            if [[ $target == "Code" ]]; then
                open -n '/Applications/Visual Studio Code.app'
            elif [[ $target == "Brave Browser" ]]; then
                open -n '/Applications/Brave Browser.app'
            else
                open -n $app_path
            fi
        fi
    fi

}
case $1 in
  setup-workspace)
      setup $AEROSPACE_FOCUSED_WORKSPACE
    ;;
  startup)
    for space in "${!workspace_map[@]}"; do
        temp=(${workspace_map[$space]})
        target=${temp[0]}
        app_path=${temp[1]}

        echo $target
        echo $id

        # get all windows that should be in this workspace
        matching_windows="$(aerospace list-windows --all --json \
            | jq -r ".[] | select(.\"app-name\" == \"${target}\") | .\"window-id\"")"

        # move em all to where they should be
        for window_id in $matching_windows; do
            aerospace move-node-to-workspace --window-id $window_id $space
        done

    done

    aerospace workspace 1
    setup 1
    ;;
  *)
      echo helper.sh setup-workspace with $AEROSPACE_FOCUSED_WORKSPACE set or
      echo           startup
    ;;
esac


