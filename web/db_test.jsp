<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Database Diagnostic</title>
    <style>
        body { font-family: sans-serif; padding: 20px; background: #f4f4f9; }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
        .info { color: #333; }
        pre { background: #eee; padding: 10px; border-radius: 5px; }
    </style>
</head>
<body>
    <h1>DB Connection Diagnostic</h1>
    <div class="info">
        <p><strong>Environment Check:</strong></p>
        <ul>
            <li>DB_PASSWORD set: <%= (System.getenv("DB_PASSWORD") != null && !System.getenv("DB_PASSWORD").isEmpty()) ? "<span class='success'>YES</span>" : "<span class='error'>NO (Please set this in Render)</span>" %></li>
        </ul>
        
        <p><strong>Attempting Connection...</strong></p>
        <%
            String url = "jdbc:mysql://mysql-240cfbf7-spamsql.i.aivencloud.com:21585/spam?useSSL=true&allowPublicKeyRetrieval=true";
            String user = "avnadmin";
            String password = System.getenv("DB_PASSWORD");
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                long start = System.currentTimeMillis();
                Connection conn = DriverManager.getConnection(url, user, password);
                long end = System.currentTimeMillis();
                out.println("<p class='success'>Successfully connected to Aiven MySQL!</p>");
                out.println("<p>Connection time: " + (end - start) + "ms</p>");
                
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT 1");
                if (rs.next()) {
                    out.println("<p class='success'>Test query (SELECT 1) executed successfully.</p>");
                }
                conn.close();
            } catch (Exception e) {
                out.println("<p class='error'>Failed to connect!</p>");
                out.println("<pre>");
                e.printStackTrace(new java.io.PrintWriter(out));
                out.println("</pre>");
                out.println("<p><strong>Tip:</strong> If you see 'Communications link failure', check if the Aiven instance is powered on and if Render's outbound IPs are allowed (though Aiven's 0.0.0.0/0 is usually recommended for simplicity during dev).</p>");
            }
        %>
    </div>
    <hr>
    <a href="index.jsp">Back to App</a>
</body>
</html>
