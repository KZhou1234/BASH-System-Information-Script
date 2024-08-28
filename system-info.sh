#!/bin/bash
while [ true ]
do
    echo "
    Please select what information you would like to get:        
    1. public and private IP addresses
    2. who you are
    3. number of CPUs you have
    4. Memory Information
    5. Top 5 Memory Processes
    6. Top 5 CPU Processes
    7. Network Connectivity
    8. Exit
    "
    read choice
    if [ $choice -eq 7 ] #only when check the network connectivity need addtional input
    then
        echo "Please enter a website or IP address you would like to test your connectivity"
        read website
        RTT=$(ping $website -c 4 | grep 'rtt' | awk -F'\/' '{print $5}') #use ping to connect
        packet_loss=$(ping $website -c 4 | grep 'packet loss' | awk -F', ' '{print $3}')
    fi
    #user-friendly script
    #get system info
    #1. IP Addresses
    #private
    private_IP=$(ip addr show enX0 | grep 'inet ' | grep -v 'inet6' | awk '{print $2}' | awk -F'/' '{print $1}')

    #public
    public_IP=$(curl ifconfig.me -s)

    #2. Current User #ex answer: "You are ubuntu."
    current_user=$(whoami)

    #3. CPU Information #ex answer: "The system has 1 CPU."     
    #cpu
    CPU_num=$(lscpu | grep 'CPU(s)' | grep -v 'On-line' | grep -v 'NUMA' | awk '{print $2}')

    #4. Memory Information #ex answer "There is 330 Mebibyte unused memory of total 957 Mebibyte."
    memory_total=$(free -m | grep 'Mem' | awk '{print $2}')
    memory_unused=$(free -m | grep 'Mem' | awk '{print $4}')
    memory_used=$(free -m | grep 'Mem' | awk '{print $3}')

    #5. Top 5 Memory Processes #This can be a table that's produced by a command, ex answer:
    top_memory=$(ps -eo pmem,pid,cmd --sort=-pmem | head -n 6 | awk '{ printf "%-5s %-8s %-30.30s\n", $1, $2, $3 }')


    #6. Top 5 CPU Processes #Same as above
    top_cpu=$(ps -eo pcpu,pid,cmd --sort=-pcpu | head -n 6 | awk '{ printf "%-5s %-8s %-30.30s\n", $1, $2, $3 }')

    #7. Network Connectivity 



    #use case statement to make selection
    case $choice in
        1)
            echo "Your public IP is $public_IP. Your private IP is $private_IP"

            ;;
        2)
            echo "You are $current_user."

            ;;
        3)
            echo "The system has $CPU_num cpu(s)"
            ;;
        4)
            echo "There is $memory_unused Mebibyte unused memory of total $memory_total Mebibyte."
            ;;
        5)
            echo "The top five memory used process are:"
            echo "$top_memory"
    
            ;;
        6)
            echo "The top five CPU used process are:"
            echo "$top_cpu"
            ;;
        7) 
            echo "It took $RTT ms to connect $website, there was $packet_loss"
            ;;
        8)
            echo "Exciting..."
            exit 0
            ;;
        *)
            echo "Please enter a vaild selection"
    esac
done