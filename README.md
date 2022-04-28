# clab-gobgp

This is a Docker container designed to be used in Containerlab to simulate an upstream ISP.

You can pull this from [Docker Hub](https://hub.docker.com/r/iparchitechs/clab-gobgp)

Pull in Docker

```bash
docker pull iparchitechs/clab-gobgp
```

## Using in Containerlab

```yaml
topology: 
  nodes:
    bgp:
      kind: linux
      image: docker.io/iparchitechs/clab-gobgp
      env:
        ip4_addr: "203.0.113.1"
        ip4_cidr: "30"
        ip6_addr: "2001:db8::1"
        ip6_cidr: "64"
        local_asn: 64496
        peer_asn: 65536
        peer_ip4: "203.0.113.2"
        peer_ip6: "2001:db8::2"
        default_route: "true"
```

## Features

### IPv4 Advertisements

For lab testing, it's usually not necessary (or wanted) to have full tables, so we only advertise the following:

- 1.1.1.0/24
- 2.2.2.0/24
- 3.3.3.0/24
- 4.4.4.0/24
- 5.5.5.0/24
- 6.6.6.0/24
- 7.7.7.0/24
- 8.8.8.0/24
- 9.9.9.0/24

If the environment variable `default_route` is set, a default route will be advertised.

### IPv6 Advertisements

For lab testing, it's usually not necessary (or wanted) to have full tables, so we only advertise the following:

- 2001:1::/32
- 2002:2::/32
- 2003:3::/32
- 2004:4::/32
- 2005:5::/32
- 2006:6::/32
- 2007:7::/32
- 2008:8::/32
- 2009:9::/32

If the environment variable `default_route` is set, a default route will be advertised.

### Testing Reachability

This container will then respond on any IP address to ICMP, TCP port 80, and TCP port 443 (self signed certificate).

From a remote Linux device, you can try the following:

```bash
ping 1.1.1.199
curl http://6.6.6.32
curl https://2.2.2.254
```

### SSH Access

In a lab environment, the end user may not always have access to the Containerlab server (nor would you want them to). This image supports SSH.

### Default usernames/passwords

As this is just for a lab environment, usernames/passwords are hardcoded:

- admin/admin
- root/root

## Future Items

This is currently a pretty barebones/quick setup

Future items:

- Allow password to be defined by user
