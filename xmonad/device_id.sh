line=$(xinput --list | grep "$1")

id_regex='id=([0-9]+)'

[[ $line =~ $id_regex ]]
echo ${BASH_REMATCH[1]}


