#!/bin/bash
set -e

# Generate missing SSH host keys
sudo ssh-keygen -A

# Start the SSH daemon in the foreground with error logging enabled
exec sudo /usr/sbin/sshd -D -e