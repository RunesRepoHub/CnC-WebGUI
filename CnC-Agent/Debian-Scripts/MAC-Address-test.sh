mac_address=$(/sbin/ifconfig ens18 | sed -n '2 p' | awk '{print $2}')

echo $mac_address

