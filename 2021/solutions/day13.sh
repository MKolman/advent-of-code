function remove_duplicates() {
    > bin/day13_uniq.txt
    for i in "${!x[@]}"; do
        echo "${x[$i]} ${y[$i]}" >> bin/day13_uniq.txt
    done

    x=()
    y=()
    sort bin/day13_uniq.txt | uniq | while read -ra xy; do
        x+=(${xy[0]})
        y+=(${xy[1]})
    done
}

function output() {
    declare -A out
    for ((i=0;i<=6;i++)) do
        for ((j=0;j<=40;j++)) do
            out[$i,$j]='.'
        done
    done

    for i in "${!x[@]}"; do
        out[${y[$i]},${x[$i]}]='#'
    done
    for ((i=0;i<=6;i++)) do
        for ((j=0;j<=40;j++)) do
            echo -n ${out[$i,$j]}
        done
        echo
    done
}

shopt -s lastpipe
x=()
y=()
while IFS=, read -ra xy; do
    if [[ -z ${xy[0]} ]]; then
        break
    fi
    x+=(${xy[0]})
    y+=(${xy[1]})
done

first=1
while IFS=" =" read -ra fold; do
    n=$(( 2*${fold[3]} ))
    for i in "${!x[@]}"; do
        if [ "${fold[2]}" == "x" ] && [[ ${x[$i]} -gt ${fold[3]} ]]; then
            x[$i]=$(( $n-${x[$i]} ))
        fi
        if [ "${fold[2]}" == "y" ] && [[ ${y[$i]} -gt ${fold[3]} ]]; then
            y[$i]=$(( $n-${y[$i]} ))
        fi
    done
    remove_duplicates
    test $first -eq 1 && echo ${#x[@]}
    first=0
done

output
