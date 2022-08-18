#!/bin/bash
<<COMMENT
    Administrative helper script use for:
        - Adding user to sudo group
        - Adding user to given group
        - Removing user from sudo group
        - Listing user's group(s)
        - Locking user account
        - Unlocking user account
COMMENT
declare -r EXIT_PROG=0
declare -r ROOT_UID=0
declare -r NON_ROOT=121
declare -r EXIT_UNKNOWN_USER=120
declare -r EXIT_UNKNOWN_GROUP=119
declare -r PROG="Manage User Account"
declare -r DESC="Administrative helper script use for: Adding user to sudo group, Removing user from sudo group,
Listing user's group(s), Locking user account and Unlocking user account."

synopsis() {
    printf "\n\t%s\n" "$(color -w "${PROG^^}")"
    printf "\n%s\n" "$(color -w "$DESC")"
    printf "\n%s%s%s%s" "$(color -o "Synopsis: ")" "$(color -w "${0}")" " $(color -w "<aAlLRru?>")" " $(color -w "<username>")"
    printf "\n%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n" \
        "$(color -o "Parameters: ")" \
        "$(color -w "?:\tPrints this message")" \
        "$(color -w "a:\tAdd user to the sudo group")" \
        "$(color -w "A:\tAdd user to the group - Synopsis: ${0} -A <user-name> <group-name>")" \
        "$(color -w "l:\tLock user acount")" \
        "$(color -w "L:\tList user's groups")" \
        "$(color -w "r:\tRemove user from the sudo group")" \
        "$(color -w "R:\tRemove user from group")" \
        "$(color -w "u:\tUnlock user account")"
}

gracefulExit() {
    exit 0
}

exitProg() {
    gracefulExit
}

commenceCleanup() {
    if [ $UID -ne "$ROOT_UID" ]; then
        printf "\n\t%s\n\n" "$(color -x 255 "$(blink "Must run this script with root privilege")")"
        exit $NON_ROOT
    else
        apt-get clean && apt-get autoremove && apt-get autoclean
        gracefulExit
    fi
}

trap "gracefulExit" INT TERM QUIT PWR

if [ $# -eq 0 ]; then
    commenceCleanup
fi
