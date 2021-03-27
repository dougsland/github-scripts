#!/usr/bin/env bash

NFS_SERVER="IP_ADDRES:/Public"
MOUNT_PATH="/super/path"

DIR_BACKUP="${MOUNT_PATH}"/"backup-github"
BACKUP_DAY="$(date +"%m-%d-%Y-%k_%M_%S")"

REPOS=(https://github.com/dougsland/bash-by-example
        https://github.com/dougsland/unifi-openvpn
        https://github.com/K8sbykeshed/cyclonus-artifacts.git
        https://github.com/K8sbykeshed/k8s-local-dev
        https://github.com/dougsland/vim-tips
        https://github.com/dougsland/misc-ovirt
        https://github.com/dougsland/kubectl-grab-resources
        https://github.com/dougsland/networkpolicies-fun
        https://github.com/dougsland/ocp-on-ovirt
        https://github.com/dougsland/python-snack-by-examples
        https://github.com/tchellomello/python-amcrest
        https://github.com/dougsland/python-by-examples
        https://github.com/dougsland/netpath
        https://github.com/dougsland/ovirt-register
        https://github.com/dougsland/python-confparser
)

# if not mounted, mount the NFS
if [ ! -d "${DIR_BACKUP}" ]
then
    mount -t nfs "${NFS_SERVER}" "${MOUNT_PATH}"
    # shellcheck disable=SC2181
    if [ $? -ne 0 ]
    then
      echo "failed to mount nfs server"
    fi
fi

mkdir -p "${DIR_BACKUP}"/"${BACKUP_DAY}"
pushd "${DIR_BACKUP}"/"${BACKUP_DAY}" || exit
    for repo in "${REPOS[@]}"; do
        echo "Clonning repo ${repo}..."
        git clone "${repo}" 1> /dev/null
        # shellcheck disable=SC2181
        if [ $? -ne 0 ]
        then
           echo "failed to mount nfs server"
        fi
    done
popd || exit
