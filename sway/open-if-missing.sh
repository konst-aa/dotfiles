#!/usr/bin/env bash

workspace=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
echo $workspace
workspace_windows=$(swaymsg -t get_workspaces \
    | jq -r ".[] | select(.name==\"$workspace\").representation" \
    | awk -F '[][]' '{print $2}')

if [[ ! ${workspace_windows[@]} =~ $1 ]]; then
    exec $2
fi
