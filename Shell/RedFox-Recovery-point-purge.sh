#!/bin/bash
set -e
for ARN in $(aws backup list-recovery-points-by-backup-vault --backup-vault-name "RedFox_Backup_Vault" --by-created-before 2021-04-13 --query 'RecoveryPoints[].RecoveryPointArn' --output text); do 
echo "deleting ${ARN} ..."
aws backup delete-recovery-point --backup-vault-name "RedFox_Backup_Vault" --recovery-point-arn "${ARN}"
done 