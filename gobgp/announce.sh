#Define BGP attributes
attr_v4="
  -a ipv4 \
  identifier 1 \
  origin igp \
  nexthop $ip4_addr \
  med 100 \
  local-pref 100 \
"



# Populate prefixes (creates 1.1.1 through 9.9.9 as /24)
for i in $(seq 1 1 9); do
  ip netns exec bgp gobgp global rib add $i.$i.$i.0/24 $attr_v4
done

if [[ -n ${default_route} ]]; then
  ip netns exec bgp gobgp global rib add 0.0.0.0/0 $attr_v4
fi

# Create Prefixes that shouldn't be accepted by the remote
ip netns exec bgp gobgp global rib add 1.1.2.0/25 $attr_v4
ip netns exec bgp gobgp global rib add 10.0.0.0/24 $attr_v4
ip netns exec bgp gobgp global rib add 224.0.2.0/24 $attr_v4

if [[ -n ${ip6_addr} ]]; then

attr_v6="
  -a ipv6 \
  identifier 1 \
  origin igp \
  nexthop $ip6_addr \
  med 100 \
  local-pref 100 \
"

  for i in $(seq 1 1 9); do
    ip netns exec bgp gobgp global rib add 200$i:$i::/32 $attr_v6
  done

  if [[ -n ${default_route} ]]; then
    ip netns exec bgp gobgp global rib add ::/0 $attr_v6
  fi

  ip netns exec bgp gobgp global rib add 2000:1:0:1::/52 $attr_v6
  ip netns exec bgp gobgp global rib add 100::/64 $attr_v6
  ip netns exec bgp gobgp global rib add 2001:10::/28 $attr_v6
  ip netns exec bgp gobgp global rib add 2001:db8::/32 $attr_v6
  ip netns exec bgp gobgp global rib add fc00::/7 $attr_v6
  ip netns exec bgp gobgp global rib add fe80::/10 $attr_v6
  ip netns exec bgp gobgp global rib add fec0::/10 $attr_v6
  ip netns exec bgp gobgp global rib add ff00::/8 $attr_v6

fi
