from troposphere import ssm
from troposphere import Ref, GetAtt, Template

template = Template()

template.add_version("2010-09-09")

SSMAssociation = template.add_resource(ssm.Association(
    'SSMAssociation',
    Name='AWS-ConfigureCloudWatch',
    DocumentVersion='$DEFAULT',
    Parameters={
        "properties": [
            """{
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
                                    "Region": "us-east-1",
                                    "LogGroup": "RedFoxAPI-Production-Beanstalk-Log-Group-httpErr",
                                    "LogStream": "{instance_id}-RedFoxAPI-Production-Beanstalk-httpErr"
                                }
                            },
                             {
                        "FullName": "AWS.EC2.Windows.CloudWatch.CloudWatchLogsOutput,AWS.EC2.Windows.CloudWatch",
                        "Id": "IISCloudWatchLogs",
                        "Parameters": {
                          "AccessKey": "",
                          "LogGroup": "RedFoxAPI-Production-Beanstalk-Log-Group-httpErr",
                          "LogStream": "{instance_id}-RedFoxAPI-Production-httpErr",
                          "Region": "us-east-1",
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
                                "Id": "PerformanceCounter",
                                "FullName": "AWS.EC2.Windows.CloudWatch.PerformanceCounterComponent.PerformanceCounterInputComponent,AWS.EC2.Windows.CloudWatch",
                                "Parameters": {
                                    "CategoryName": "Memory",
                                    "CounterName": "Available MBytes",
                                    "InstanceName": "",
                                    "MetricName": "Memory",
                                    "Unit": "Megabytes",
                                    "DimensionName": "",
                                    "DimensionValue": ""
                                }
                            },
                            {
                                "Id": "CloudWatchLogs",
                                "FullName": "AWS.EC2.Windows.CloudWatch.CloudWatchLogsOutput,AWS.EC2.Windows.CloudWatch",
                                "Parameters": {
                                    "AccessKey": "",
                                    "SecretKey": "",
                                    "Region": "us-east-1",
                                    "LogGroup": "RedFoxAPI-Production-Beanstalk-System-Logs",
                                    "LogStream": "{instance_id}-RedFoxAPI-Production-Beanstalk-System-Logs"
                                }
                            },
                            {
                                "Id": "CloudWatch",
                                "FullName": "AWS.EC2.Windows.CloudWatch.CloudWatch.CloudWatchOutputComponent,AWS.EC2.Windows.CloudWatch",
                                "Parameters": 
                                {
                                    "AccessKey": "",
                                    "SecretKey": "",
                                    "Region": "us-east-1",
                                    "NameSpace": "Windows/RedFoxAPI-Production"
                                }
                            }
                        ],
                
                        "Flows": {
                            "Flows": 
                            [
                                "(ApplicationEventLog,SystemEventLog),CloudWatchLogs",
                                "IISLogs,IISCloudWatchLogs",
                                "HttpErrLogs,HttpErrCloudWatchLogs",
                                "PerformanceCounter,CloudWatch"
                            ]
                        }
                    }
                }
"""
        ],
        "status": [
            'Enabled'
        ]
    },
    ScheduleExpression='cron(0 */30 * * * ? *)',
    OutputLocation=ssm.InstanceAssociationOutputLocation(
        S3Location=ssm.S3OutputLocation(
            OutputS3BucketName='sigue-redfoxapi-production-iis-error-logs'
        )
    ),
    AssociationName='RedFoxAPI-Production-ElasticBeanstalk',
    Targets=[
        ssm.Targets(
            Key='tag:elasticbeanstalk:environment-name',
            Values=[
                'RedFoxAPI-Production'
            ]
        )
    ]
))

SSMDocument = template.add_resource(ssm.Document(
    'SSMDocument',
    Name='Ashadmin_Ec2CloudWatchLogs',
    Content="""        {
        	"schemaVersion": "1.0",
        	"description": "Example CloudWatch Logs tasks",
        	"runtimeConfig": {
        		"aws:cloudWatch": {
        			"properties": {
        				"EngineConfiguration": {
        					"PollInterval": "00:00:15",
        					"Components": [{
        						"Id": "ApplicationEventLog",
        						"FullName": "AWS.EC2.Windows.CloudWatch.EventLog.EventLogInputComponent,AWS.EC2.Windows.CloudWatch",
        						"Parameters": {
        							"LogName": "Application",
        							"Levels": "1"
        						}
        					}, {
        						"Id": "SystemEventLog",
        						"FullName": "AWS.EC2.Windows.CloudWatch.EventLog.EventLogInputComponent,AWS.EC2.Windows.CloudWatch",
        						"Parameters": {
        							"LogName": "System",
        							"Levels": "7"
        						}
        					}, {
        						"Id": "SecurityEventLog",
        						"FullName": "AWS.EC2.Windows.CloudWatch.EventLog.EventLogInputComponent,AWS.EC2.Windows.CloudWatch",
        						"Parameters": {
        							"LogName": "Security",
        							"Levels": "7"
        						}
        					}, {
        						"Id": "ETW",
        						"FullName": "AWS.EC2.Windows.CloudWatch.EventLog.EventLogInputComponent,AWS.EC2.Windows.CloudWatch",
        						"Parameters": {
        							"LogName": "Microsoft-Windows-WinINet/Analytic",
        							"Levels": "7"
        						}
        					}, {
        						"Id": "IISLogs",
        						"FullName": "AWS.EC2.Windows.CloudWatch.CustomLog.CustomLogInputComponent,AWS.EC2.Windows.CloudWatch",
        						"Parameters": {
        							"LogDirectoryPath": "C:\\Program Files\\Amazon\\CloudWatch\\Logs",
        							"TimestampFormat": "yyyy-MM-dd HH:mm:ss",
        							"Encoding": "UTF-8",
        							"Filter": "",
        							"CultureName": "en-US",
        							"TimeZoneKind": "Local"
        						}
        					}, {
        						"Id": "CustomLogs",
        						"FullName": "AWS.EC2.Windows.CloudWatch.CustomLog.CustomLogInputComponent,AWS.EC2.Windows.CloudWatch",
        						"Parameters": {
        							"LogDirectoryPath": "C:\\Program Files\\Amazon\\CloudWatch\\Logs",
        							"TimestampFormat": "MM/dd/yyyy HH:mm:ss",
        							"Encoding": "UTF-8",
        							"Filter": "",
        							"CultureName": "en-US",
        							"TimeZoneKind": "Local"
        						}
        					}, {
        						"Id": "PerformanceCounter",
        						"FullName": "AWS.EC2.Windows.CloudWatch.PerformanceCounterComponent.PerformanceCounterInputComponent,AWS.EC2.Windows.CloudWatch",
        						"Parameters": {
        							"CategoryName": "Memory",
        							"CounterName": "Available GigaBytes",
        							"InstanceName": "",
        							"MetricName": "Memory",
        							"Unit": "GigaBytes",
        							"DimensionName": "ID",
        							"DimensionValue": "{instance_id}"
        						}
        					}, {
        						"Id": "CloudWatchLogs",
        						"FullName": "AWS.EC2.Windows.CloudWatch.CloudWatchLogsOutput,AWS.EC2.Windows.CloudWatch",
        						"Parameters": {
        							"AccessKey": "",
        							"SecretKey": "",
        							"Region": "us-east-1",
        							"LogGroup": "Ec2ConfigCloudWatchLogs",
        							"LogStream": "{instance_id}"
        						}
        					}, {
        						"Id": "CloudWatch",
        						"FullName": "AWS.EC2.Windows.CloudWatch.CloudWatch.CloudWatchOutputComponent,AWS.EC2.Windows.CloudWatch",
        						"Parameters": {
        							"AccessKey": "",
        							"SecretKey": "",
        							"Region": "us-east-1",
        							"NameSpace": "Windows/Default"
        						}
        					}],
        					"Flows": {
        						"Flows": [
        
        							"PerformanceCounter,CloudWatch",
        
        							"ApplicationEventLog,(CloudWatchLogs)"
        						]
        					}
        				}
        			}
        		}
        	}
        }
""",
    DocumentType='Command'
))

print(template.to_yaml())
