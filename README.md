Netbeans
=====================================================================================
Please use netbeans to skip the next three phase(or not).
Netbeans makes life easier :).

gaileo.bat
======================================================================================
To use batch file, download maven and tomcat into project root directory (apache-maven, apache-tomcat). Galileo is deployed in context path /galileo.
You can modify the batch file to suit your installation.

Maven
=======================================================================================
- An IDE with maven support is sufficient to build project.
- Text editor with local maven installation can also be used
- Android JSON and Oracle jdbc driver dependencies are locally installed. You can find the jar in the alt folder. I strongly advise you download `ojdbc` from the provider, Oracle.

Apache Tomcat
========================================================================================
- An IDE with tomcat plugin is sufficient to deploy and run
- You can deploy war file to a local installation of Tomcat
- Tomcat version 8+

Polymer Design & Google Chrome
==========================================================================================
Project uses [Polymer Design](https://www.polymer-project.org/) which is in development phase, please use Google chrome to debug and test client side navigation.
Polymer urls that depends on the [git repository](https://github.com/OlayinkaSF/olayinkasf.github.io) can be easily modified.
You can download the repository into the resources folder or install in another context. After all you have to do is modify the prefix
		https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer
to the preferred one.

Spring
==============================================================================================
The only part I've to worry about is the database dependencies. The current project uses Oracle database and `oracle.jdbc.pool.OracleDataSource` datasource to simplify pooling. Of course, you can use embedded H2 or MySQL or PostgreSQL, all you have to do is modify the dependencies in `data.xml`.
An alternative file foe H2 is provided in `alt`. To use this add the H2 dependency to the pom file.
<pre>
<code>
	   &lt;dependency&gt;
			&lt;groupId&gt;com.h2database&lt;/groupId&gt;
			&lt;artifactId&gt;h2&lt;/artifactId&gt;
			&lt;version&gt;1.3.159&lt;/version&gt;
	    &lt;/dependency&gt;
</code>
</pre>
When in trouble please read Spring's documentation.

Spring Social
=============================================================================================
I use a slightly modified [spring-social-twitter](https://github.com/OlayinkaSF/spring-social-twitter) to get coordinates from tweets. It is not a very good one but I'm working on it. I've provided a jar in the `alt` folder to support the maven dependency. Install the jar to the local repository.