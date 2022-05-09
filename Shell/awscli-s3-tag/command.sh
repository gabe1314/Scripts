#!/bin/sh
aws s3api put-bucket-tagging --bucket	sigue-jenkins-ci --tagging file://s3-tagging.json
aws s3api put-bucket-tagging --bucket	c33configbucket	--tagging file://s3-tagging.json
aws s3api put-bucket-tagging --bucket	q33sossdb1	--tagging file://s3-tagging.json
aws s3api put-bucket-tagging --bucket	sftshare	--tagging file://s3-tagging.json
aws s3api put-bucket-tagging --bucket	sigoro.com	--tagging file://s3-tagging.json
aws s3api put-bucket-tagging --bucket	sigue-acuity-bucket-c33	--tagging file://s3-tagging.json
