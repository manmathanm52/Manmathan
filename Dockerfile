FROM tomcat:9.0-jdk8
WORKDIR /app
COPY . .

# Create target classes directory and lib directory
RUN mkdir -p web/WEB-INF/classes web/WEB-INF/lib

# Download missing Apache Commons IO library required by sends.java


# Compile all Java source code using Tomcat's built-in Java EE libraries!
# This bypasses NetBeans' missing server path errors entirely.
RUN javac -cp "web/WEB-INF/lib/*:/usr/local/tomcat/lib/*" \
    -d web/WEB-INF/classes \
    src/java/dataset/*.java src/java/spam/*.java

# Clear out the default Tomcat ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT && mkdir /usr/local/tomcat/webapps/ROOT

# Copy the completely compiled web folder over to Tomcat's active ROOT
RUN cp -r web/* /usr/local/tomcat/webapps/ROOT/

# Provide MySQL 8 Connector directly to Tomcat fixing the 1251 Authentication Error
RUN wget https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar -O /usr/local/tomcat/lib/mysql-connector-j.jar

EXPOSE 8080
CMD ["catalina.sh", "run"]
