# System Information

## Summary
The goal of this practice is to create a Bash script that will help users retrieve system information efficiently. The key is to focus on user-friendliness so that the user can easily access the information. 
To accomplish this goal, I decided to use `case` statements that allow the user to select the information they need through clear instructions. The system information requested by the user is obtained by a series of monitoring commands.
## Smaple outputs 
```
1. IP Addresses #ex answer: "Your private IP is 172.31.1.150, and you public IP is 3.235.129.224."
2. Current User #ex answer: "You are ubuntu."
3. CPU Information #ex answer: "The system has 1 CPU." 
4. Memory Information #ex answer "There is 330 Mebibyte unused memory of total 957 Mebibyte."
5. Top 5 Memory Processes #This can be a table that's produced by a command, ex answer:

"pmem   pid       cmd 
 2.9        8047    /usr/lib/snapd/snapd
 2.7        181      /sbin/multipathd -d -s
 2.3        664      /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
 2.1        516      /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
 1.6        524      /snap/amazon-ssm-agent/7993/amazon-ssm-agent"

6. Top 5 CPU Processes #Same as above
7. Network Connectivity #ask user for a website or IP address to connect to first and then produce a statement regarding the network connection, ex answer: "It took 7ms to connect to www.google.com and there was 0% data packet loss."
```

## Steps

1. Based on the requirements, the script should allow users to choose from the menu until they want to exit. To implement this, we can use a while loop and specify the exit condition


<div align="center">
  <img width="808" alt="image" src="https://github.com/user-attachments/assets/a9bf67a0-4772-4396-93ba-ea9e16d8c650">
</div>  

  
2. To get the IP address, we can use the command `ip addr show` to display all the information. After that, we need to extract only the IP address from the given data by executing `ip addr show enX0 | grep 'inet ' | grep -v 'inet6' | awk '{print $2}' | awk -F'/' '{print $1}'`
<div align="center">
  <img width="1050" alt="image" src="https://github.com/user-attachments/assets/8dca8a53-cc80-4039-b754-a2087c2b992d">
</div>


Now we can get the clear private IP address.


<div align="center">
  <img width="808" alt="image" src="https://github.com/user-attachments/assets/23070787-b32e-4917-9b5b-411742b73b0c">
</div>


3. In order to get the public IP address, we can use `curl ifconfig.me`. `ifconfig.me` is a web service that displays information about the connection. With `curl`, we can get the public IP address. 


<div align="center">
  <img width="953" alt="image" src="https://github.com/user-attachments/assets/1ddafe49-264a-42ad-a5b8-ef2486547f59">
</div>


4. Get the user by using `whoami`


5. Use command `lscpu` we can get tons of info about cpu. To get the number of CPUs, we only need CPU(S) listed below.


<div align="center">
  <img width="1776" alt="image" src="https://github.com/user-attachments/assets/d3cab805-0bf7-4564-8bb2-567e36af91ce">
</div>


6. Get the memory infomation, we can use `free`. `-m` will display the output in Mebibyte. And from the output, we are able to select the right information according to users input.  


7. `ps` command is used to monitor the system. And `-eo` is to list custmoized columns that I would like to match the sample output. Sort the output and get top five processes. And because the output of column could be very long, I used  `awk '{ printf "%-5s %-8s %-30.30s\n", $1, $2, $3 }` to limit the output.


<div align="center">
  <img width="667" alt="image" src="https://github.com/user-attachments/assets/4f87979a-0c1c-4c95-a1fe-87fb52b48ad5">
</div>


8. Same logic and for get top five CPU usage process, but display different columns `ps -eo pcpu,pid,cmd --sort=-pcpu`
9. To test the network connectivity, the command `ping` can be used, which sending out the packets to an endpoint that user input. Here I specify the packets sent to be 4 and take the average RTT as the time traveling and get the packet loss also from the output.

<div align="center">
  <img width="792" alt="image" src="https://github.com/user-attachments/assets/f38c799d-f8a8-4625-9b8a-a6f2db4ba3ce">
</div>



## Conclusions
This practice is my first time working with the case statement. 
I chose the case statement instead of if-else because I think it is more readable and efficient. 
In this practice, all the choices should be given at the beginning, which makes more sense to use the case statement by my understanding.
