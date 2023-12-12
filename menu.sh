#!/bin/bash
if [[ $(ulimit -c) != "0" ]]; then
  echo "Im Watching You..."
  echo "- @user_legend"
  exit 1
fi

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
IP=$(curl -sS ipinfo.io/ip > /tmp/ipaddress.txt)
MYIP=$(cat /tmp/ipaddress.txt)

# cek wget & curl
if ! which wget > /dev/null; then
clear
echo -e "${red}Wah Mau Belajar Nakal Yah !${NC}"
sleep 2
exit 0
clear
else
echo "Wget is already installed"
fi

if ! which curl > /dev/null; then
clear
echo -e "${red}Wah Mau Belajar Nakal Yah !${NC}"
sleep 2
exit 0
clear
else
echo "curl is already installed"
fi

fileee=/usr/bin/wget
minimumsize=400000
actualsize=$(wc -c <"$fileee")
if [ $actualsize -ge $minimumsize ]; then
clear
echo -e "${green}Checking...${NC}"
else
clear
echo -e "${red}Permission Denied!${NC}";
echo "Reason : Modified Package To Bypass Sc"
exit 0
fi

fileeex=/usr/bin/curl
minimumsizex=15000
clear
actualsizex=$(wc -c <"$fileeex")
if [ $actualsizex -ge $minimumsizex ]; then
clear
echo -e "${green}Checking...${NC}"
else
clear
echo -e "${red}Permission Denied!${NC}";
echo "Reason : Modified Package To Bypass Sc"
exit 0
fi


# data server
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
cekcloudflare=$(curl -sS http://ip-api.com/json | jq .as | grep -o "Cloudflare")
if [[ "$cekcloudflare" = "Cloudflare" ]]; then
cekdomen=$(cat /etc/xray/domain)
MYIP=$(dig +short "$cekdomen" | head -n 1)
fi
repogithub='darkness11231/premium/main'
clear

echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${red}                         [ MAIN MENU ]                         ${NC}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green [•1]  $NC MENU SSH,SLOWDNS & OVPN [${green}menu-ssh${NC}]"
echo -e "$green [•2]  $NC MENU VMESS WS [${green}menu-vmess${NC}]"
echo -e "$green [•3]  $NC MENU VMESS GRPC [${green}menu-vmessgrpc${NC}]"
echo -e "$green [•4]  $NC MENU VMESS TCP HTTP [${green}menu-vmesstcp${NC}]"
echo -e "$green [•5]  $NC MENU VLESS WS [${green}menu-vless${NC}]"
echo -e "$green [•6]  $NC MENU VLESS GRPC [${green}menu-vlessgrpc${NC}]"
echo -e "$green [•7]  $NC MENU VLESS TCP XTLS [${green}menu-vlessxtls${NC}]"
echo -e "$green [•8]  $NC MENU TROJAN WS [${green}menu-trws${NC}]"
echo -e "$green [•9]  $NC MENU TROJAN TCP [${green}menu-tr${NC}]"
echo -e "$green [•10] $NC MENU TROJAN GRPC [${green}menu-trgrpc${NC}]"
echo -e "$green [•11] $NC MENU SHADOWSOCKS2022 [${green}menu-ss${NC}]"
echo -e "$green [•12] $NC MENU L2TP [${green}menu-l2tp${NC}]"
echo -e "$green [•13] $NC MENU BUNDLING [${green}menu-bundling${NC}]"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${red}                        [ OTHER MENU ]                         ${NC}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green [•14] $NC CHANGE DOMAIN OR FORCE DOMAIN [${green}force-host${NC}]"
echo -e "$green [•15] $NC CHANGE SLOWDNS MODE [${green}change-slowdns${NC}]"
echo -e "$green [•16] $NC CHANGE PORT [${green}change-port${NC}]"
echo -e "$green [•17] $NC CHANGE UUID OR PASSWORD ACCOUNT VPN [XRAY] [${green}change-uuid${NC}]"
echo -e "$green [•18] $NC CHANGE ALTERNATIF PORT [${green}change-alt-port${NC}]"
echo -e "$green [•19] $NC AUTOBACKUP VIA GMAIL [${green}autobackup${NC}]"
echo -e "$green [•20] $NC AUTOBACKUP VIA BOT TELEGRAM [${green}backup-bot${NC}]"
echo -e "$green [•21] $NC AUTOSEND TRIAL VPN VIA BOT TELEGRAM [${green}auto-sendvpn${NC}]"
echo -e "$green [•22] $NC BACKUP VIA GMAIL [${green}backup${NC}]"
echo -e "$green [•23] $NC BACKUP VIA BOT TELEGRAM [${green}bckp-bot${NC}]"
echo -e "$green [•24] $NC MONITORING CPU USAGE [${green}htop${NC}]"
echo -e "$green [•25] $NC LIMIT BANDWITH SPEED SERVER [${green}limit-speed${NC}]"
echo -e "$green [•26] $NC CHECK USAGE OF RAM [${green}ram${NC}]"
echo -e "$green [•27] $NC RESTART ALL SERVICES [${green}restart${NC}]"
echo -e "$green [•28] $NC RESTORE DATA VPS [${green}restore${NC}]"
echo -e "$green [•29] $NC UPDATE KERNEL TO LATEST VERSION [${green}update-kernel${NC}]"
echo -e "$green [•30] $NC CHANGE KERNEL TYPE 'CLOUD' TO ANOTHER VERSION [${green}fix-kernel-cloud${NC}]"
echo -e "$green [•31] $NC INSTALL WEBMIN [${green}wbmn${NC}]"
echo -e "$green [•32] $NC SPEEDTEST SERVER [${green}speedtest${NC}]"
echo -e "$green [•33] $NC RETURN TO BEGINNING MENU [${green}menu2${NC}]"
echo -e "$green [•34] $NC WARP CLOUDFLARE [${green}warp${NC}]"
echo -e "$green [•35] $NC VIEW SERVER'S TOTAL BANDWIDTH [${green}vnstat${NC}]"
echo -e "$green [•36] $NC VIEW PROTOCOL & PORT INFORMATION [${green}info${NC}]"
echo -e "$green [•37] $NC REBOOT SERVER [${green}reboot${NC}]"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${red}  CLIENT NAME :${NC} $clientname        |      ${red}EXP DATE :${NC} $exp  "
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e   ""
echo -e "[CTRL + C] For Exit From Main Menu"
echo -e   ""
read -p "Select From Options [1-37 or x] :  " menu
echo -e ""
case $menu in
1)
menu-ssh
;;
2)
menu-vmess
;;
3)
menu-vmessgrpc
;;
4)
menu-vmesstcp
;;
5)
menu-vless
;;
6)
menu-vlessgrpc
;;
7)
menu-vlessxtls
;;
8)
menu-trws
;;
9)
menu-tr
;;
10)
menu-trgrpc
;;
11)
menu-ss
;;
12)
menu-l2tp
;;
13)
menu-bundling
;;
14)
force-host
;;
15)
change-slowdns
;;
16)
change-port
;;
17)
change-uuid
;;
18)
change-alt-port
;;
19)
autobackup
;;
20)
backup-bot
;;
21)
auto-sendvpn
;;
22)
backup
;;
23)
bckp-bot
;;
24)
htop
;;
25)
limit-speed
;;
26)
ram
;;
27)
restart
;;
28)
restore
;;
29)
update-kernel
;;
30)
fix-kernel-cloud
;;
31)
wbmn
;;
32)
speedtest
;;
33)
menu2
;;
34)
warp
;;
35)
vnstat
;;
36)
info
;;
37)
reboot
;;
x)
clear
menu2
;;
*)
echo " Please Choose Number !"
sleep 2 
menu
;;
esac