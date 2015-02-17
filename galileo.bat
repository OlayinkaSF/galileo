set PATH=apache-maven\bin;%PATH%

rmdir "apache-tomcat\webapps\galileo" /s /q
rmdir "apache-tomcat\work\Catalina\localhost\galileo" /s /q

rmdir "apache-tomcat\logs" /s /q

call mvn clean
call mvn compile
call mvn package

del "apache-tomcat\webapps\galileo.war"
copy "target\galileo-1.0-SNAPSHOT.war" "apache-tomcat\webapps\galileo.war"

cd apache-tomcat\bin
call startup
cd ..\..

pause
