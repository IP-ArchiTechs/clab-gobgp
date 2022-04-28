#!/bin/bash
ip address add dev eth1 $ip4_addr/$ip4_cidr

if [[ -n ${ip6_addr} ]]; then

    ip address add dev eth1 $ip6_addr/$ip6_cidr

fi

tc qdisc replace dev eth1 root netem rate 1Mbit
