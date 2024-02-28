#!/bin/bash

username=$PAM_USER
administrators_group="admins"

# Check if the user is a member of the administrators group
if getent group $administrators_group | grep -q "\b${username}\b"; then
    usermod -aG $administrators_group $username
fi

exit 0
