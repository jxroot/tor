#!/bin/bash
apt update -y
apt install tor -y 
service tor stop
export PORT=1194
echo ' VirtualAddrNetwork 10.192.0.0/10
       AutomapHostsOnResolve 1
       DNSPort 10.8.0.1:53530
       TransPort 10.8.0.1:$PORT' >> /etc/tor/torrc
service tor start
echo '
#!/bin/bash
export IPTABLES=/sbin/iptables
export OVPN=tun0
export PORT=1194
$IPTABLES -A INPUT -i $OVPN -s 10.8.0.0/24 -m state --state NEW -j ACCEPT
$IPTABLES -t nat -A PREROUTING -i $OVPN -p udp --dport 53 -s 10.8.0.0/24 -j DNAT --to-destination 10.8.0.1:53530
$IPTABLES -t nat -A PREROUTING -i $OVPN -p tcp -s 10.8.0.0/24 -j DNAT --to-destination 10.8.0.1:$PORT
$IPTABLES -t nat -A PREROUTING -i $OVPN -p udp -s 10.8.0.0/24 -j DNAT --to-destination 10.8.0.1:$PORT
'>/root/iptable.sh
bash /root/iptable.sh
systemctl enable cron
crontab -l > iptable
echo "@reboot bash /root/iptable.sh" >> iptable
crontab iptable
rm iptable
