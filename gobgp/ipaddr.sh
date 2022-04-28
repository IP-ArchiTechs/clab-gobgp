#!/bin/bash
ip netns add bgp


ip netns exec bgp ip link set dev lo up

ip link set dev eth1 netns bgp up

ip netns exec bgp ip address add dev eth1 $ip4_addr/$ip4_cidr

if [[ -n ${ip6_addr} ]]; then

    ip netns exec bgp ip address add dev eth1 $ip6_addr/$ip6_cidr

fi

ip netns exec bgp tc qdisc replace dev eth1 root netem rate 1Mbit
