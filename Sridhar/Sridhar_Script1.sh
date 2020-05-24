#!/bin/bash
export CATALINA_BASE=/root/projects/DummyApplication
LOGILE=/root/projects/DummyApplication/deploy_`date +%Y%m%d\ %H:%M:%S`.log

Report()
{
	ARG=$*
	echo `date +%Y%m%d\ %H:%M:%S`" -I- $ARG" | tee -a $LOGILE
}

Error()
{
	ARG=$*
	echo `date +%Y%m%d\ %H:%M:%S`" -E- $ARG" | tee -a $LOGILE
	exit 1
}

Command_Error()
{
	RET=$1
	COMMENT=$2
	if [ $RET -ne 0 ]
	then
		Error "Error duting $COMMENT"
	fi
}

Function_Start()
{ 
	#start the application
	Report  "Starting DummyApplication application..."
	sudo $CATALINA_BASE/startup.sh
	sleep 10s
	
	pid_count=`ps -ef | grep -i DummyApplication | grep -v grep | wc -l`

	if [ $pid_count -eq 1 ]
	then
		Report  "Process is brought up successfully..."
	else
		Error  "Failed to bring the application up..."		
	fi
}


Function_Stop()
{
	pid_count=`ps -ef | grep -i DummyApplication | grep -v grep | wc -l`
	if [ $pid_count -eq 0 ]
	then
		Report "Process is already not running..."
	else
		#stop the apllication and check whether it is stoped or not once done go to next
		sudo $CATALINA_BASE/shutdown.sh
		sleep 10s
		pid_count=`ps -ef | grep -i DummyApplication | grep -v grep | wc -l`
		if [ $pid_count -eq 1 ]
		then
			Report "Process is still running in background so killing it forcefully..."
			ps -ef | grep -i DummyApplication | grep -v grep | awk '{print $2}' | xargs kill -9
		else
			Report  "Process is stopped successfully..."
		fi
	fi
}

Funtion_Deploy()
{
	#backup
	cp $CATALINA_BASE/conf/Catalina/localhost/ABCD.war  /opt/DummyApplication/ABCD.war-$BUILD_NUMBER
	Command_Error $? "backup file $CATALINA_BASE/conf/Catalina/localhost/ABCD.war"
	#after back up remove it
	rm -f $CATALINA_BASE/conf/Catalina/localhost/ABCD.war
	Command_Error $? "remove file $CATALINA_BASE/conf/Catalina/localhost/ABCD.war"
	#also remoove the ROOT dir in webapps.
	rm -rf $CATALINA_BASE/webapps/ROOT
	Command_Error $? "remove directory $CATALINA_BASE/webapps/ROOT"
	#copy/deploy the latest war in the application.
	cp /var/lib/jenkins/workspace/DummyApplication_build/target/*.war   $CATALINA_BASE/conf/Catalina/localhost/ABCD.war
	Command_Error $? "copy /var/lib/jenkins/workspace/DummyApplication_build/target/*.war to $CATALINA_BASE/conf/Catalina/localhost/ABCD.war"
}

Report " Start of script "`basename $0`

Function_Stop
Funtion_Deploy
Function_Start

Report " End of script "`basename $0`

