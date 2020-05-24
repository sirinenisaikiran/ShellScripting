#set path
export CATALINA_BASE=/root/projects/Detroit
#go to that path
cd $CATALINA_BASE/
#stop the apllication and check whether it is stoped or not once done go to next
sudo ./shutdown.sh
sleep 10
#coping old war file to backup dir
cp $CATALINA_BASE/conf/Catalina/localhost/itoa.war  /opt/Detroit/itoa.war-$BUILD_NUMBER
#after back up remove it
rm -rf $CATALINA_BASE/conf/Catalina/localhost/itoa.war
#also remoove the ROOT dir in webapps.
rm -rf $CATALINA_BASE/webapps/*
#copy/deploy the latest war in the application.
cp /var/lib/jenkins/workspace/Detroit_build/target/*.war   $CATALINA_BASE/conf/Catalina/localhost/itoa.war
#go to the script path
cd $CATALINA_BASE/
#start the application
sudo ./startup.sh
#check whether the application process is created or not
sleep 20
#later check the url with curl command
curl http://192.168.101.174:8083


Edhi anna na requirement