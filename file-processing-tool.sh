#!/bin/bash

function help_msg() {
    echo -e "View and processing of given files.\n\nUsage:\n\t$0"
}

if [ "$1" == '-h' ]; then
    help_msg
    exit 0
fi

if [ $# -lt 1 ]; then
    help_msg
    exit 1
fi

function main() {
    
    declare -a files=($*)
    declare -a selected=('Selected:')
    declare -a edited=('Edited:')
    declare -a deleted=('Deleted:')
    #log='ps-file-processing.log'
    function printa() {
        array=($1)
        if [ ${#array[*]} -gt 1 ]
        then
            printf "%s\n" "${array[@]}"
        fi
    }
    i=0

    while [ $i -ge 0 ] && [ $i -lt ${#files[*]} ]
    do
        f=${files[$i]}
        if [ ! -f ${f} ]; then
            files=(${files[@]/$f})
            continue
        fi
        clear
        printf "%$((`tput cols`))s\n" "[$i:${#files[*]}]"
        head_cols=$((`tput lines`-15))
        head -n${head_cols} ${f}
        if [ `cat ${f} | wc -l` -gt ${head_cols} ]
        then
            echo "------------------------------ 8< ------------------------------"
            tail -n3 ${f}
        fi
        echo
        echo -e "What do you want to do with the file ${f}?"
        echo -n "Choose (e)dit, (d)elete, (r)eplace the first string of php file, (a)dd to selection, (n)ext, (p)revious or (q)uit "
        while true
        do
            read -s -n1 choise
            echo "${choise}"
            case "${choise}" in
                e)
                    /usr/bin/vim ${f}
                    edited+=($f)
                    i=$(($i+1))
                    break
                    ;;
                d)
                    /bin/rm -f ${f}
                    deleted+=($f)
                    i=$(($i+1))
                    break
                    ;;
                r)
                    /bin/sed -i '1c\<?php' ${f}
                    edited+=($f)
                    i=$(($i+1))
                    break
                    ;;
                p)
                    i=$(($i-1))
                    break
                    ;;
                a)
                    selected+=($f)
                    i=$(($i+1))
                    break
                    ;;
                n)
                    i=$(($i+1))
                    break
                    ;;
                q)
                    clear
                    printa "${selected[*]}"
                    printa "${edited[*]}"
                    printa "${deleted[*]}"
                    exit 0
                    ;;
                *)
                    break
                    ;;
            esac
        done
    done
    clear
    printa "${selected[*]}"
    printa "${edited[*]}"
    printa "${deleted[*]}"

}

main $*
