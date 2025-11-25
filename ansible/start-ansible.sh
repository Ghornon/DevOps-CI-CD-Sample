#!/bin/bash
export $(grep -v '^#' ../.env | xargs)
ansible-playbook configure_docker.yml -i hosts.ini
