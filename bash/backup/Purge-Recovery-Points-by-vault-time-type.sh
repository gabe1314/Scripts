#!/bin/bash
set -e
for ARN in $(aws backup list-recovery-points-by-backup-vault --backup-vault-name "Acuity_backup_vault" --by-created-before 2020-12-30 --by-resource-type EC2 --query 'RecoveryPoints[].Recovery$
echo "deleting ${ARN} ..."
aws backup delete-recovery-point --backup-vault-name "Acuity_backup_vault" --recovery-point-arn "${ARN}"
done