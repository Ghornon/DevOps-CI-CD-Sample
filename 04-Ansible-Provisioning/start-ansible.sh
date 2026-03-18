#!/bin/bash
export $(grep -v '^#' ../.secrets | xargs)

#!/bin/bash
GH_USERNAME=$(gh repo view --json owner -q ".owner.login")
DB_PASSWORD="V2OFJ8@yyDYW9l7ckh*&"

ansible-playbook configure_docker.yml -i hosts.ini
