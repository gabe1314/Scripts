#!/bin/bash
while [[ backup ]] ; do
  backup=`aws backup list-recovery-points-by-backup-vault --backup-vault-name Default --max-results 1 | jq -r ".RecoveryPoints[].RecoveryPointArn"`
  echo "Deleting $backup..."
  `aws backup delete-recovery-point --backup-vault-name Default --recovery-point-arn $backup`
done
