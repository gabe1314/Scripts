AWSTemplateFormatVersion: "2010-09-09"
Metadata:
    Generator: "former2"
Description: ""
Resources:
    SSMAssociation:
        Type: "AWS::SSM::Association"
        Properties:
            Name: "AWS-ConfigureCloudWatch"
            DocumentVersion: "$DEFAULT"
            Parameters: 
                properties: 
                  - !Sub |
                    {
                        "IsEnabled": true,
                        "EngineConfiguration": {
                            "PollInterval": "00:00:05",
                            "Components": [
                                {
                                    "Id": "ApplicationEventLog",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.EventLog.EventLogInputComponent,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                        "LogName": "Application",
                                        "Levels": "1"
                                    }
                                },
                                {
                                    "Id": "SystemEventLog",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.EventLog.EventLogInputComponent,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                        "LogName": "System",
                                        "Levels": "7"
                                    }
                                },
                                {
                                    "Id": "SecurityEventLog",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.EventLog.EventLogInputComponent,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                    "LogName": "Security",
                                    "Levels": "7"
                                    }
                                },
                                {
                                    "Id": "ETW",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.EventLog.EventLogInputComponent,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                        "LogName": "Microsoft-Windows-WinINet/Analytic",
                                        "Levels": "7"
                                    }
                                },
                                {
                                    "Id": "IISLogs",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.CustomLog.CustomLogInputComponent,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                        "LogDirectoryPath": "C:\\inetpub\\logs\\LogFiles\\W3SVC1",
                                        "TimestampFormat": "yyyy-MM-dd HH:mm:ss",
                                        "Encoding": "UTF-8",
                                        "Filter": "",
                                        "CultureName": "en-US",
                                        "TimeZoneKind": "UTC",
                                        "LineCount": "3"
                                    }
                                },
                                {
                                    "Id": "HttpErrLogs",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.CustomLog.CustomLogInputComponent,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                        "LogDirectoryPath": "C:\\Windows\\System32\\LogFiles\\HTTPERR",
                                        "TimestampFormat": "yyyy-MM-dd HH:mm:ss",
                                        "Encoding": "UTF-8",
                                        "Filter": "",
                                        "CultureName": "en-US",
                                        "TimeZoneKind": "UTC",
                                        "LineCount": "3"
                                    }
                                },
                                {
                                    "Id": "HttpErrCloudWatchLogs",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.CloudWatchLogsOutput,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                        "AccessKey": "",
                                        "SecretKey": "",
                                        "Region": "${AWS::Region}",
                                        "LogGroup": "SigueLink-Production-FrontEndServers-Log-Group-httpErr",
                                        "LogStream": "{instance_id}-SigueLink-Production-FrontEndServers-httpErr"
                                    }
                                },
                                 {
                            "FullName": "AWS.EC2.Windows.CloudWatch.CloudWatchLogsOutput,AWS.EC2.Windows.CloudWatch",
                            "Id": "IISCloudWatchLogs",
                            "Parameters": {
                              "AccessKey": "",
                              "LogGroup": "SigueLink-Production-FrontEndServers-Log-Group-httpErr",
                              "LogStream": "{instance_id}-SigueLink-Production-FrontEndServers-httpErr",
                              "Region": "${AWS::Region}",
                              "SecretKey": ""
                            }
                          },
                                {
                                    "Id": "CustomLogs",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.CustomLog.CustomLogInputComponent,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                        "LogDirectoryPath": "C:\\CustomLogs\\",
                                        "TimestampFormat": "MM/dd/yyyy HH:mm:ss",
                                        "Encoding": "UTF-8",
                                        "Filter": "",
                                        "CultureName": "en-US",
                                        "TimeZoneKind": "Local"
                                    }
                                },
                                {
                                    "Id": "PerformanceCounterMemory",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.PerformanceCounterComponent.PerformanceCounterInputComponent,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                        "CategoryName": "Memory",
                                        "CounterName": "Available MBytes",
                                        "InstanceName": "",
                                        "MetricName": "Memory",
                                        "Unit": "Megabytes",
                                        "DimensionName": "InstanceName",
                                        "DimensionValue": "{instance_id}-SigueLink-Production-FrontEndServers-Memory"
                                    }
                                },
                                {
                                        "Id": "PerformanceCounterDiskC",
                                        "FullName": "AWS.EC2.Windows.CloudWatch.PerformanceCounterComponent.PerformanceCounterInputComponent,AWS.EC2.Windows.CloudWatch",
                                        "Parameters": {
                                        "CategoryName": "LogicalDisk",
                                        "CounterName": "% Free Space",
                                        "InstanceName": "C:",
                                        "MetricName": "FreeSpaceC",
                                        "Unit": "Gigabytes",
                                        "DimensionName": "InstanceName",
                                        "DimensionValue": "{instance_id}-SigueLink-Production-FrontEndServers-C-Drive"
                                        }
                                        },
                                        {
                                        "Id": "PerformanceCounterDiskE",
                                        "FullName": "AWS.EC2.Windows.CloudWatch.PerformanceCounterComponent.PerformanceCounterInputComponent,AWS.EC2.Windows.CloudWatch",
                                        "Parameters": {
                                        "CategoryName": "LogicalDisk",
                                        "CounterName": "% Free Space",
                                        "InstanceName": "E:",
                                        "MetricName": "FreeSpaceE",
                                        "Unit": "Gigabytes",
                                        "DimensionName": "InstanceName",
                                        "DimensionValue": "{instance_id}-SigueLink-Production-FrontEndServers-E-Drive"
                                        }
                                        },
                                {
                                    "Id": "CloudWatchLogs",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.CloudWatchLogsOutput,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": {
                                        "AccessKey": "",
                                        "SecretKey": "",
                                        "Region": "${AWS::Region}",
                                        "LogGroup": "SigueLink-Production-FrontEndServers-CW-Logs",
                                        "LogStream": "{instance_id}-SigueLink-Production-FrontEndServers-CW-Logs"
                                    }
                                },
                                {
                                    "Id": "CloudWatch",
                                    "FullName": "AWS.EC2.Windows.CloudWatch.CloudWatch.CloudWatchOutputComponent,AWS.EC2.Windows.CloudWatch",
                                    "Parameters": 
                                    {
                                        "AccessKey": "",
                                        "SecretKey": "",
                                        "Region": "${AWS::Region}",
                                        "NameSpace": "Windows/SigueLink-Production-FrontEndServers"
                                    }
                                }
                            ],
                    
                            "Flows": {
                                "Flows": 
                                [
                                    "(ApplicationEventLog,SystemEventLog),CloudWatchLogs",
                                    "IISLogs,IISCloudWatchLogs",
                                    "HttpErrLogs,HttpErrCloudWatchLogs",
                                    "(PerformanceCounterMemory,PerformanceCounterDiskC,PerformanceCounterDiskE), CloudWatch"
                                ]
                            }
                        }
                    }
                status: 
                  - "Enabled"
            ScheduleExpression: "cron(0 */30 * * * ? *)"
            OutputLocation: 
                S3Location: 
                    OutputS3BucketName: "siguelink-production-front-end-servers"
            AssociationName: "SigueLink-Production-FrontEndServers"
            Targets: 
              - 
                Key: "resource-groups:Name"
                Values: 
                  - "SigueLink-Production-FrontEndServers"

