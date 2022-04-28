self=$ip_addr

#Define BGP attributes
attr_v4="
  -a ipv4 \
  identifier 1 \
  origin igp \
  nexthop $self \
  med 100 \
  local-pref 100 \
"

# Populate prefixes (creates 1.1.1 through 9.9.9 as /24)
for i in $(seq 1 1 9); do
  gobgp global rib add $i.$i.$i.0/24 $attr_v4
done

if [[ -n ${default_route} ]]; then
  gobgp global rib add 0.0.0.0/0 $attr_v4
fi

# Create Prefixes that shouldn't be accepted by the remote
gobgp global rib add 1.1.2.0/25 $attr_v4
gobgp global rib add 10.0.0.0/24 $attr_v4
gobgp global rib add 224.0.2.0/24 $attr_v4