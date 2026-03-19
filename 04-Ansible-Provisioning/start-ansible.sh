#!/bin/bash
export $(grep -v '^#' ../.secrets | xargs)
export GH_USERNAME=$(gh repo view --json owner -q ".owner.login")

ansible-playbook configure_docker.yml -i hosts.ini
