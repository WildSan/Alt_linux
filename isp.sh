#!bin/bash
mkdir /etc/net/ifaces/ens19
mkdir /etc/net/ifaces/ens20
echo "BOOTPROTO=static" | sudo tee -a /etc/net/ifaces/ens19/options
echo "TYPE=eth" | sudo tee -a /etc/net/ifaces/ens19/options
cp /etc/net/ifaces/ens19/options /etc/net/ifaces/ens20/
echo "172.16.4.1/28" > /etc/net/ifaces/ens19/ipv4address
echo "172.16.5.1/28" > /etc/net/ifaces/ens20/ipv4address
iptables -A INPUT -i lo -j ACCEPT 
iptables -A INPUT -i ens19 -j ACCEРТ
iptables -A INPUT -i eth38 -j ACCEРТ
iptables -A FORWARD -i ens19 -o ens18 -m conntrack --ctstate NEW -j АССЕРТ
iptables -A FORWARD -i eth38 -o ens18 -m conntrack --ctstate NEW -j АССЕРТ
iptables -A FORWARD -i ens19 -o ens20 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -i ens20 -o ens19 -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -A POSTROUTING -o ens18(ГЛОБАЛЬНЫЙ) -j MASQUERADE
iptables-save > /etc/sysconfig/iptables
systemctl enable --now iptables