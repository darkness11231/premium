#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# Warna
bold='\033[1m'
red='\e[1;31m'
green='\e[0;32m'
yellow='\e[1;33m'
NC='\e[0m'

# Fungsi cek dan install paket jika belum ada
check_pkg() {
    if ! dpkg -s "$1" >/dev/null 2>&1; then
        echo -e "${yellow}Installing $1 ...${NC}"
        apt install -y "$1"
    else
        echo -e "${green}$1 already installed, skip.${NC}"
    fi
}

# Update dan install dependensi
apt update -y && apt upgrade -y
check_pkg wget
check_pkg curl
check_pkg lolcat
check_pkg figlet
check_pkg jq
check_pkg dnsutils
check_pkg socat
check_pkg git
check_pkg python3-pip

# Deteksi OS
source /etc/os-release
OS=$ID
if [[ $OS == 'debian' || $OS == 'ubuntu' ]]; then
    cp /usr/games/lolcat /usr/bin 2>/dev/null || true
fi

# Cek virtualisasi
if [[ "$(systemd-detect-virt)" =~ (openvz|ovz) ]]; then
    echo "OpenVZ is not supported"
    exit 1
fi

# Cek root
if [ "${EUID}" -ne 0 ]; then
    echo "You need to run this script as root"
    exit 1
fi

# Cek integritas wget
fileee=/usr/bin/wget
minimumsize=400000
actualsize=$(wc -c <"$fileee")
if [ $actualsize -lt $minimumsize ]; then
    echo -e "${red}Permission Denied!${NC}"
    echo "Reason : Modified Package To Bypass Sc"
    exit 0
fi

# Cek integritas curl
fileeex=/usr/bin/curl
minimumsizex=15000
actualsizex=$(wc -c <"$fileeex")
if [ $actualsizex -lt $minimumsizex ]; then
    echo -e "${red}Permission Denied!${NC}"
    echo "Reason : Modified Package To Bypass Sc"
    exit 0
fi

# Data server & IP
IP=$(curl -sS ipinfo.io/ip > /tmp/ipaddress.txt)
MYIP=$(cat /tmp/ipaddress.txt)
repogithub='darkness11231/premium/main'

# Deteksi Cloudflare IP
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
cekcloudflare=$(curl -sS http://ip-api.com/json | jq .as | grep -o "Cloudflare")
if [[ "$cekcloudflare" = "Cloudflare" ]]; then
    cekdomen=$(cat /etc/xray/domain 2>/dev/null)
    MYIP=$(dig +short "$cekdomen" | head -n 1)
fi

clear
figlet -f small -t "       WILLIAM" | lolcat
echo -e "                 ${green}AUTOSCRIPT INSTALLER v1${NC}  -  ${bold}©2020-2023${NC}"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "     $red TELEGRAM $NC : t.me/user_legend"
echo -e "     $red FACEBOOK $NC : https://www.facebook.com/userlegend69"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

while [[ ! "$opsi" =~ ^[1-2]$ ]]
do
echo ""
echo -e "${bold}Silahkan Pilih !:"
echo -e "1. Menggunakan Domain Sendiri [using your own domain]"
echo -e "2. Menggunakan Domain Dari Script [using domain from script]${NC}"
echo ""
read -p "Masukkan angka opsi: " -n 1 -r opsi

if [[ $opsi == "1" ]]; then
    echo ""
    echo "Opsi 1 terpilih ✓"
    read -p "Input Your Domain  : " domen
    echo ""
    sleep 1
    echo -e "Tutorial How to Pointing NS Domain"
    echo -e "Readme : https://t.me/autoscript_willstore69/44"
    echo ""
    read -p "Input Your NS Domain : " domens
    echo "Proses... Mohon Menunggu"
    sleep 2
    mkdir -p /var/lib/premium-script /etc/xray /etc/v2ray /etc/ns
    touch /etc/xray/domain /etc/v2ray/domain /etc/ns/domain
    echo "IP=$domen" > /var/lib/premium-script/ipvps.conf
    echo $domen > /etc/xray/domain
    echo $domen > /etc/v2ray/domain
    echo $domens > /etc/ns/domain

elif [[ $opsi == "2" ]]; then
    echo ""
    echo "Opsi 2 terpilih ✓"
    sleep 2
    echo -e "Anda Akan Menggunakan Domain ${bold}x-project-vpn.com${NC}"
    sleep 2
    echo -e "Dengan Random Subdomain Yang Dipilih Oleh Script"
    sleep 2
    echo -e "Tetapi Jika IP Anda Telah Terdeteksi Pernah Menggunakan Domain Dari Script."
    sleep 1
    echo -e "${bold}System Akan Memprioritaskan Itu.${NC}"
    sleep 4
    echo "Check Domain...."
    sleep 3
    MYIP=$(curl -s ipinfo.io/ip)
    AUTH_EMAIL="rizkihdyt6@gmail.com"
    AUTH_KEY="15c999c8f900f4d36851f95d05f9c34b9130a"
    DOMAIN="x-project-vpn.com"

    ZONE_ID=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
         -H "X-Auth-Email: ${AUTH_EMAIL}" \
         -H "X-Auth-Key: ${AUTH_KEY}" \
         -H "Content-Type: application/json" | jq -r .result[0].id)

    DNS_RECORDS=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?per_page=1000" \
    -H "X-Auth-Email: $AUTH_EMAIL" \
    -H "X-Auth-Key: $AUTH_KEY" \
    -H "Content-Type: application/json")

    echo "${DNS_RECORDS}" | jq -r '.result[] | @base64' > /tmp/hasil-enc.txt
    base64 -d /tmp/hasil-enc.txt > /tmp/decoded_file.txt
    dns_record_json=$(cat /tmp/decoded_file.txt)
    id=$(echo "${dns_record_json}" | jq -r '.id')
    name=$(echo "${dns_record_json}" | jq -r '.name')
    content=$(echo "${dns_record_json}" | jq -r '.content')
    paste <(echo "$name") <(echo "$content") > /tmp/hasil-paste.txt
    ip_hasil=$(grep -w "$MYIP" /tmp/hasil-paste.txt)

    if [ -z "$ip_hasil" ]; then
        echo ""
        echo "Tidak Ada IP Yang Terdaftar Di System..."
        sleep 2
        echo "Pointing IP Otomatis...."
        sleep 3
        wget --no-check-certificate -q https://raw.githubusercontent.com/$repogithub/cf.sh && chmod +x cf.sh && ./cf.sh && rm -rf cf.sh
    else
        cek_domain=$(grep -w "$MYIP" /tmp/hasil-paste.txt | awk '{print $1}' | tr -d '*' | head -1 | sed 's/^\.//')
        echo ""
        echo "IP $MYIP Pernah Dipointing Dengan $cek_domain"
        echo "System Akan Otomatis Melanjutkan Dengan Domain : $cek_domain"
        sleep 3
        mkdir -p /var/lib/premium-script /etc/xray /etc/v2ray /etc/ns
        touch /etc/xray/domain /etc/v2ray/domain /etc/ns/domain
        echo "IP=$cek_domain" > /var/lib/premium-script/ipvps.conf
        echo $cek_domain > /etc/xray/domain
        echo $cek_domain > /etc/v2ray/domain
        echo dns.$cek_domain > /etc/ns/domain
    fi
fi
done

sleep 3
source /etc/os-release
OS=$ID
if [[ $OS == 'debian' || $OS == 'ubuntu' ]]; then
    cp /usr/games/lolcat /usr/bin 2>/dev/null || true
fi
clear
sleep 1
domainku=$(cat /etc/xray/domain)
echo "Your Domain Is $domainku"
echo -e "$green Starting..... $NC"
sleep 2
LOOKUP=$(nslookup "$domainku" | awk -F':' '/^Address: / { matched = 1 } matched { print $2}' | grep "$MYIP" | cut -d " " -f 2)
echo -e "$green Check Domain Is valid and pointed To IP Address $NC"
sleep 2
if [[ $MYIP = $LOOKUP ]]; then
    echo -e "$green Domain is Valid ! $NC"
else
    echo -e "$red UPS ! looks like the domain you entered is not valid"
    echo -e "$red please recheck the domain you entered is correct"
    echo -e "$red please point the domain to ip and try again $NC"
    exit 0
fi

# Tambah direktori
mkdir -p /etc/xray/vmess /etc/william /var/lib/premium-script
touch /etc/xray/domain /etc/v2ray/domain /var/lib/premium-script/ipvps.conf /etc/william/subscribe

hostnameku=$(cat /etc/xray/domain)
echo -e "Checking Certificate...."
mkdir -p /etc/ssl/private/
touch /etc/ssl/private/fullchain.pem /etc/ssl/private/privkey.pem
FILEEXX=/etc/ssl/private/fullchain.pem
if [[ -z $(grep '[^[:space:]]' $FILEEXX) ]]; then
    echo -e "${yellow}Certificate Not Found !${NC}"
    echo -e "Starting Added Certificate Please wait..."
    sleep 3
    check_pkg socat
    export ACME_USE_WGET=1
    if ! [ -d /root/.acme.sh ]; then curl https://get.acme.sh | sh; fi
    ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    ~/.acme.sh/acme.sh --upgrade --auto-upgrade
    ~/.acme.sh/acme.sh --issue -d $hostnameku --standalone --keylength ec-384 --force \
        && ~/.acme.sh/acme.sh --install-cert -d $hostnameku --ecc \
        --fullchain-file /etc/ssl/private/fullchain.pem \
        --key-file /etc/ssl/private/privkey.pem
    chown -R nobody:nogroup /etc/ssl/private/
    chmod 777 /etc/ssl/private/
else
    echo -e "${green}Certificate Found ! skipped.${NC}"
fi
sleep 1
clear

# Install layanan
wget --no-check-certificate -q https://raw.githubusercontent.com/$repogithub/setup-sshvpn.sh && chmod +x setup-sshvpn.sh && ./setup-sshvpn.sh && rm -rf setup-sshvpn.sh
wget --no-check-certificate -q https://raw.githubusercontent.com/$repogithub/set-br.sh && chmod +x set-br.sh && ./set-br.sh && rm -rf set-br.sh
wget --no-check-certificate -q https://raw.githubusercontent.com/$repogithub/ssh-ws-ssl.sh && chmod +x ssh-ws-ssl.sh && ./ssh-ws-ssl.sh && rm -rf ssh-ws-ssl.sh
wget --no-check-certificate -q https://raw.githubusercontent.com/$repogithub/sstp.sh && chmod +x sstp.sh && ./sstp.sh && rm -rf sstp.sh
wget --no-check-certificate -q https://raw.githubusercontent.com/$repogithub/wireguard.sh && chmod +x wireguard.sh && ./wireguard.sh && rm -rf wireguard.sh
wget --no-check-certificate -q https://raw.githubusercontent.com/$repogithub/only-l2tp.sh && chmod +x only-l2tp.sh && ./only-l2tp.sh && rm -rf only-l2tp.sh
wget --no-check-certificate -q https://raw.githubusercontent.com/$repogithub/requirement.sh && chmod +x requirement.sh && ./requirement.sh && rm -rf requirement.sh

# Install subfinders
cd /usr/bin
git clone https://github.com/willstore69/subfinders
cd subfinders
python3 -m pip install -r requirements.txt
mv knockpy /usr/bin
mv ingfo /usr/bin
cd /usr/bin
rm -rf /usr/bin/subfinders
chmod +x ingfo
cd

# Set permission SSL
chown -R nobody:nogroup /etc/ssl/private/
chmod 777 /etc/ssl/private/
chmod +x /etc/ssl/private/fullchain.pem
chmod +x /etc/ssl/private/privkey.pem
systemctl restart xray

# Re-check sertifikat
if [[ -z $(grep '[^[:space:]]' $FILEEXX) ]]; then
    echo -e "${yellow}Certificate Not Found !${NC}"
    echo -e "Starting Added Certificate Please wait..."
    sleep 3
    check_pkg socat
    export ACME_USE_WGET=1
    if ! [ -d /root/.acme.sh ]; then curl https://get.acme.sh | sh; fi
    ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    ~/.acme.sh/acme.sh --upgrade --auto-upgrade
    ~/.acme.sh/acme.sh --issue -d $hostnameku --standalone --keylength ec-384 --force \
        && ~/.acme.sh/acme.sh --install-cert -d $hostnameku --ecc \
        --fullchain-file /etc/ssl/private/fullchain.pem \
        --key-file /etc/ssl/private/privkey.pem
    chown -R nobody:nogroup /etc/ssl/private/
    chmod 777 /etc/ssl/private/
fi
clear

# Informasi selesai
echo " "
echo "Installation has been completed!!"
echo "==========================- AUTOSCRIPT -============================="  | tee -a /root/log-install.txt
echo "   >>> Service & Port"  | tee -a /root/log-install.txt
echo "   - Webmin                  : 10000"  | tee -a /root/log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a /root/log-install.txt
echo "   - OpenVPN TCP             : 1194"  | tee -a /root/log-install.txt
echo "   - OpenVPN UDP             : 2200"  | tee -a /root/log-install.txt
echo "   - OpenVPN SSL             : 442"  | tee -a /root/log-install.txt
echo "   - SSHWS                   : 2052"  | tee -a /root/log-install.txt
echo "   - XRAY TLS                : 443"  | tee -a /root/log-install.txt
echo "   - VMNONE                  : 80"  | tee -a /root/log-install.txt
echo "   - VLNONE                  : 8880"  | tee -a /root/log-install.txt
echo "=================================================================="  | tee -a /root/log-install.txt
echo "Reboot 15 Sec"
sleep 15
reboot
