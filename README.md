## Easy_init script

It is a easy init system script for CentOS7, include following functions:

### Introduction
1. Get OS environment;
2. Configure IP address, DNS and router;
3. Add SA user;
4. Configure SSHD file add public key;
5. Set yum source;
6. Install basic software;
7. Configure software environment;
8. Other configuration;

### Usage
```
    su -
    curl http://18.18.96.10/easy_init/easy_init.sh > easy_init.sh
    chmod +x ./easy_init.sh
    ./easy_init.sh
```
