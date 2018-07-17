#!/bin/bash


#echo "What message you want to show to end user"

while true
do
    echo -e "                 ┌─────────────────────────────────────────────────────────────────────┐
                 │              • \033[01;92mSelect Operation $(hostname)\033[0m  •                     │
                 │                                                                     │
                 │ ➤ \033[01;96m1. View indices with size\033[0m                                         │
                 │                                                                     │
                 │ ➤ \033[01;96m2. Delete index\033[0m                                                   │
                 │                                                                     │
                 │ ➤ \033[01;96m3. Exit\033[0m                                                           │
                 │                                                                     │
                 │ ➤ \033[01;96m4. Clear\033[0m                                                          │
                 └─────────────────────────────────────────────────────────────────────┘"

    echo -ne  "Enter your choice: "
    read  input_user
#   echo $input_user

        case $input_user in
                        1)
                                        echo -e "\033[01;92mView indices command will be executed shortly.\033[0m"
                                        curl 'http://localhost:9200/_cat/indices' | sort -k 3
                                        echo
                                        echo
                                        echo -e "\033[01;92mView indices Operation ended\033[0m"
                                        ;;
                        2)
                                        echo -ne "Enter the Index name that needs to \033[01;91mdeleted\033[0m: "
                                        read input_index
                                        echo -e "\033[01;91mDelete index command will be executed shortly for $input_index.\033[0m"
                                        curl -XDELETE localhost:9200/"$input_index"/
                                        echo
                                        echo
                                        echo -e "\033[01;92mDelete index Operation ended for $input_index.\033[0m"
                                        ;;
                        3)
                                        echo -e "\033[01;12mExiting the script. B.Bye..\033[0m"
                                        exit
                                        ;;
                        4)
                                        clear
                                        ;;
                        *)
                                        echo "Enter a valid option"
                                        ;;
        esac

done

