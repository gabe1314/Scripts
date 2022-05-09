#!/bin/bash
set -e
for ARN in $(aws backup list-recovery-points-by-backup-vault --backup-vault-name "CRM_BACKUP_VAULT" --by-created-before 2021-04-28T22:16:52.330000-07:00 --by-resource-type EC2 --max-results 100  --query 'RecoveryPoints[].RecoveryPointArn' --output text); do
echo "deleting ${ARN} ..."
aws backup delete-recovery-point --backup-vault-name "CRM_BACKUP_VAULT" --recovery-point-arn "${ARN}"
done