#!/bin/bash

# configure IP address
bash /gobgp/ipaddr.sh

# respond to all addresses that are advertised
ip netns exec bgp ip -4 route add local 0.0.0.0/0 dev lo
ip netns exec bgp ip -6 route add local ::/0 dev lo

cat > /gobgp/isp_config.yml << EOL
global:
  config:
    as: ${local_asn}
    router-id: ${ip4_addr}
neighbors:
  - config:
      neighbor-address: ${peer_ip4}
      peer-as: ${peer_asn}
    afi-safis:
      - config:
          afi-safi-name: ipv4-unicast

EOL

if [[ -n ${ip6_addr} ]]; then

cat >> /gobgp/isp_config.yml << EOL
  - config:
      neighbor-address: ${peer_ip6}
      peer-as: ${peer_asn}
    afi-safis:
      - config:
          afi-safi-name: ipv6-unicast

EOL


fi

# start gobgpd daemon
ip netns exec bgp gobgpd -t yaml -f /gobgp/isp_config.yml > /log &
sleep 5

# make ipv4 BGP announcement
bash /gobgp/announce.sh