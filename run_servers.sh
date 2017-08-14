#!/bin/bash
echo "Showing the container's ip:"
ip addr show | grep 'eth0'
echo "Starting sshd:"
/etc/init.d/ssh start >>/debugStart.txt 2>&1
