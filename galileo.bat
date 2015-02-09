taskkill /f /im jqs.exe
taskkill /f /im javaw.exe
taskkill /f /im java.exe
rmdir "C:\Program Files\Apache Software Foundation\Apache Tomcat 8.0.15\webapps\galileo" /s /q
rmdir "C:\Program Files\Apache Software Foundation\Apache Tomcat 8.0.15\work\Catalina\localhost\galileo" /s /q
rmdir "C:\Users\Olayinka\AppData\Roaming\NetBeans\8.0.2\apache-tomcat-8.0.15.0_base\logs" /s /q
del "C:\Program Files\Apache Software Foundation\Apache Tomcat 8.0.15\webapps\galileo.war"
copy "C:\Users\Olayinka\Documents\Repo\galileo\galileo-web\target\galileo-web-a-1.0-SNAPSHOT.war" "C:\Program Files\Apache Software Foundation\Apache Tomcat 8.0.15\webapps\galileo.war"
cd C:\Program Files\Apache Software Foundation\Apache Tomcat 8.0.15\bin
startup
