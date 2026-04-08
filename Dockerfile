# Step 1: NetBeans Project Build (using Ant and Java 8)
FROM frekele/ant:1.10.3-jdk8 AS builder
WORKDIR /app
COPY . .
# Run NetBeans ant build (this creates dist/EMAIL.war)
RUN ant -f build.xml clean dist

# Step 2: Deploy to Tomcat Server
FROM tomcat:9.0-jdk8-openjdk
# Remove default Tomcat apps to keep it clean
RUN rm -rf /usr/local/tomcat/webapps/ROOT
# Copy the compiled war file from Step 1 as ROOT.war so it runs on main URL ( / )
COPY --from=builder /app/dist/EMAIL.war /usr/local/tomcat/webapps/ROOT.war

# Fix NetBeans old driver issue by injecting the latest MySQL 8 Connector directly into Tomcat
RUN wget https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar -O /usr/local/tomcat/lib/mysql-connector-j.jar

EXPOSE 8080
CMD ["catalina.sh", "run"]
