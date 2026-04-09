package spam;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://mysql-240cfbf7-spamsql.i.aivencloud.com:21585/spam?useSSL=true&allowPublicKeyRetrieval=true";
        String user = "avnadmin";
        String password = System.getenv("DB_PASSWORD");
        
        if (password == null || password.trim().isEmpty()) {
            throw new SQLException("Environment Variable 'DB_PASSWORD' is missing. Please set it locally or in Render configuration.");
        }
        
        return DriverManager.getConnection(url, user, password);
    }
}
