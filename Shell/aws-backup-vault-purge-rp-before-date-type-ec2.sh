#!/bin/bash

set -e

echo "Enter the name of the vault where all backups should be deleted"
read VAULT_NAME

for ARN in $(aws backup list-recovery-points-by-backup-vault --backup-vault-name "${VAULT_NAME}" --by-created-before 2021-04-01  --query 'RecoveryPoints[].RecoveryPointArn' --output text); do 
  echo "deleting ${ARN} ..."
  aws backup delete-recovery-point --backup-vault-name "${VAULT_NAME}" --recovery-point-arn "${ARN}"
done 