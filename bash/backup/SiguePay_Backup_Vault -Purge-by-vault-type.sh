#!/bin/bash
set -e
for ARN in $(aws backup list-recovery-points-by-backup-vault --backup-vault-name "SiguePay_Backup_Vault" --by-created-before 2022-09-28T22:16:52.330000-07:00  --max-results 1000 --by-resource-type EC2 --query 'RecoveryPoints[].RecoveryPointArn' --output text); do
echo "deleting ${ARN} ..."
aws backup delete-recovery-point --backup-vault-name "SiguePay_Backup_Vault" --recovery-point-arn "${ARN}"
done