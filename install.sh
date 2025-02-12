#!/bin/bash

set -e

if [ -t 1 ]; then
    RED="\e[1;31m"
    GREEN="\e[1;32m"
    YELLOW="\e[1;33m"
    BLUE="\e[1;34m"
    RESET="\e[0m"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    RESET=""
fi

get_su()
{
    if [ "$EUID" -ne 0 ]; then
        echo -e "${BLUE}🔒 Requesting superuser privileges...${RESET}"
        sudo bash "$0" "$@" || fail "Superuser privileges required."
        exit
    fi
}

put_as_binary()
{
    INSTALL_DIR="/usr/local/bin"
    TMP_FILE=$(mktemp)

    echo -e "${BLUE}⬇ Creating the binary caillou...${RESET}"
    curl -sL -o "$TMP_FILE" https://raw.githubusercontent.com/FloWindels/Mini_shell1_bash_tests/main/run_tests.sh || fail "Failed to download the run_tests file"
    mv "$TMP_FILE" "$INSTALL_DIR/caillou"
    chmod 755 "$INSTALL_DIR/caillou"
    echo -e "${GREEN}✔ Installed caillou to $INSTALL_DIR/caillou${RESET}"
}

main()
{
    get_su "$@"
    put_as_binary
    rm -- "$0"
}

main "$@"