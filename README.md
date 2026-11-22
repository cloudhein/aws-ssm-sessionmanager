### Install SessionManager Plugin on your laptop
```
https://docs.aws.amazon.com/systems-manager/latest/userguide/install-plugin-macos-overview.html
```
```
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac_arm64/session-manager-plugin.pkg" -o "session-manager-plugin.pkg"
```
```
sudo installer -pkg session-manager-plugin.pkg -target /

sudo ln -s /usr/local/sessionmanagerplugin/bin/session-manager-plugin /usr/local/bin/session-manager-plugin
```
```
rm -rf session-manager-plugin.pkg 
```

### Terraform Outputs
```
Outputs:

instance_ids = {
  "instance01" = "i-0b1bb7c7f55111fec"
  "instance02" = "i-069684c79e25c8c7e"
  "instance03" = "i-0dfaad7db059108bd"
}
session_manager_commands = {
  "instance01" = "aws ssm start-session --target i-0b1bb7c7f55111fec"
  "instance02" = "aws ssm start-session --target i-069684c79e25c8c7e"
  "instance03" = "aws ssm start-session --target i-0dfaad7db059108bd"
}
session_manager_role_arn = "arn:aws:iam::xxxxxxx:role/frontend-session-manager-role"
vpc_endpoints = {
  "ec2_messages" = "vpce-0155ac603c2db2dec"
  "ssm" = "vpce-07ad51b32c2297511"
  "ssm_messages" = "vpce-080635a8e8c789ac7"
}
```

## To Connect to your private EC2 instances
### To connect to private instance 01
```
$ aws ssm start-session --target i-0b1bb7c7f55111fec --profile admin-master-harry-console

Starting session with SessionId: admin-master-harry-console-6onvbyry8azyl7fiungog7sboa
$ whoami
ssm-user
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enX0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc fq_codel state UP group default qlen 1000
    link/ether 06:ff:e4:5b:7e:81 brd ff:ff:ff:ff:ff:ff
    inet 10.0.253.166/24 metric 100 brd 10.0.253.255 scope global dynamic enX0
       valid_lft 2847sec preferred_lft 2847sec
    inet6 fe80::4ff:e4ff:fe5b:7e81/64 scope link 
       valid_lft forever preferred_lft forever
$ hostname
ip-10-0-253-166
```
### To connect to private instance 02
```
$ aws ssm start-session --target i-069684c79e25c8c7e --profile admin-master-harry-console

Starting session with SessionId: admin-master-harry-console-dtn8c9ua2h5nyzy5i3v6ixd3di
$ whoami
ssm-user
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enX0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc fq_codel state UP group default qlen 1000
    link/ether 02:ff:ef:7e:22:0f brd ff:ff:ff:ff:ff:ff
    inet 10.0.254.228/24 metric 100 brd 10.0.254.255 scope global dynamic enX0
       valid_lft 2428sec preferred_lft 2428sec
    inet6 fe80::ff:efff:fe7e:220f/64 scope link 
       valid_lft forever preferred_lft forever
$ hostname
ip-10-0-254-228
```

### To connect to private instance 03
```
aws ssm start-session --target i-0dfaad7db059108bd --profile admin-master-harry-console

Starting session with SessionId: admin-master-harry-console-vq29ij4ihiapctneizcyo93ry4
$ whoami
ssm-user
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enX0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc fq_codel state UP group default qlen 1000
    link/ether 0a:ff:e6:4d:e0:63 brd ff:ff:ff:ff:ff:ff
    inet 10.0.255.50/24 metric 100 brd 10.0.255.255 scope global dynamic enX0
       valid_lft 2327sec preferred_lft 2327sec
    inet6 fe80::8ff:e6ff:fe4d:e063/64 scope link 
       valid_lft forever preferred_lft forever
$ hostname
ip-10-0-255-50
```

## Architecture
![Detailed architecture of the secure mgmt with SSM through VPC endpoints](assets/aws-ssm-manager-vpc-endpoint-lld.png)
