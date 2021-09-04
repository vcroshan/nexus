# Nexus Installation
Prequisties 
  To install nexus minimum server requirements are with 4CPU and 8GB RAM. Use t3.xlarge for AWS instance for better performance
  
Use the userdata-amazaonlinux2 script to install docker and docker compose in the amazonlinux2 instance

execute the docker compose yml file to deploy Nexus on the server
# Configure repositories in Nexus
1. Configure a blob storage for each of the below
    a. maven-snapshots
    b. maven-releases
    c. maven-central
2. configure a maven snapshot repository
A repository for Maven artifacts that you deploy with -SNAPSHOT in the end of the version tag of your pom.xml:

`<version>1.0.0-SNAPSHOT</version>`
Create a new maven (hosted) repository and configure it like:

![image](https://user-images.githubusercontent.com/20510066/132102877-f877d83d-2323-4583-8f58-35a4fd822264.png)


3. configure a maven release repository
A repository for Maven artifact that you deploy without -SNAPSHOT in the end of the version tag of your pom.xml:

`<version>1.0.0</version>`
Create a new maven (hosted) repository and configure it like:

![image](https://user-images.githubusercontent.com/20510066/132102884-91f66929-94b9-4050-bdd1-135fb2fc175d.png)

4. Create a proxy for Maven Central
A repository that proxies everything you download from Maven Central. Next time you download the same dependency, it will be cached in your Nexus.

Create a new maven (proxy) repository and configure it like:
![image](https://user-images.githubusercontent.com/20510066/132102907-f7c5f463-0188-4eaa-a221-4ad6a1f252ac.png)

5. create a group repo

![image](https://user-images.githubusercontent.com/20510066/132102934-e6819c56-b536-4c26-a8e1-56252cbadb24.png)

6. configure your maven client to use nexus repo

Put this in your settings.xml file. This will configure the credentials to publish to your hosted repos, and will tell your mvn to use your repo as a mirror of central:
```
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">

  <servers>
    <server>
      <id>nexus-snapshots</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
    <server>
      <id>nexus-releases</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
  </servers>

  <mirrors>
    <mirror>
      <id>central</id>
      <name>central</name>
      <url>http://your-host:8081/repository/maven-group/</url>
      <mirrorOf>*</mirrorOf>
    </mirror>
  </mirrors>

</settings>```

7. Put the below in your pom.xml
```<project>
  <repositories>
    <repository>
      <id>maven-group</id>
      <url>http://your-host:8081/repository/maven-group/</url>
    </repository>
  </repositories>

    <distributionManagement>
    <snapshotRepository>
      <id>maven-snapshots</id>
      <url>http://your-host:8081/repository/maven-snapshots/</url>
    </snapshotRepository>
    <repository>
      <id>maven-releases</id>
      <url>http://your-host:8081/repository/maven-releases/</url>
    </repository>
  </distributionManagement>
 </project>```

8. deploy the package to nexus using maven command : mvn clean deploy
