#set path
export CATALINA_BASE=/root/projects/DummyApplication
#go to that path
cd $CATALINA_BASE/
#stop the apllication and check whether it is stoped or not once done go to next
sudo ./shutdown.sh
sleep 10
#coping old war file to backup dir
cp $CATALINA_BASE/conf/Catalina/localhost/ABCD.war  /opt/DummyApplication/ABCD.war-$BUILD_NUMBER
#after back up remove it
rm -rf $CATALINA_BASE/conf/Catalina/localhost/ABCD.war
#also remoove the ROOT dir in webapps.
rm -rf $CATALINA_BASE/webapps/*
#copy/deploy the latest war in the application.
cp /var/lib/jenkins/workspace/DummyApplication_build/target/*.war   $CATALINA_BASE/conf/Catalina/localhost/ABCD.war
#go to the script path
cd $CATALINA_BASE/
#start the application
sudo ./startup.sh
#check whether the application process is created or not
sleep 20
