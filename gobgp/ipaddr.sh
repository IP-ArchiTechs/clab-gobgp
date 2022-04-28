#!/bin/bash
ip address add dev eth1 $ip4_addr/$ip4_cidr

tc qdisc replace dev eth1 root netem rate 1Mbit
