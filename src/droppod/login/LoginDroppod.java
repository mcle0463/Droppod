package droppod.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LoginDroppod {
    public static boolean validate(String name, String pass) {        
        boolean status = false;
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        String filename = "config.properties";
        Properties prop = new Properties();
        try {
			prop.load(Thread.currentThread().getContextClassLoader().getResourceAsStream(filename));
		} catch (IOException e1) {
			e1.printStackTrace();
			/* Since we cant connnect to the db, we wont be able to authenticate
			 * therefore, we return false. */
			return false;
		}
        /*
        String url = "jdbc:mysql://localhost:3306/";
        String dbName = "droppod";
        String driver = "com.mysql.jdbc.Driver";
        String userName = prop.getProperty("dbuser");
        String password = prop.getProperty("dbpassword");
        */
        try {
            /*
            Class.forName(driver).newInstance();
            conn = DriverManager
                    .getConnection(url + dbName, userName, password);

            pst = conn
                    .prepareStatement("select * from users where username=? and password=?");
            pst.setString(1, name);
            pst.setString(2, pass);

            rs = pst.executeQuery();
            status = rs.next();
            */
        	Context envContext = new InitialContext();
            Context initContext  = (Context)envContext.lookup("java:/comp/env");
            DataSource ds = (DataSource)initContext.lookup("jdbc/droppod");
            //DataSource ds = (DataSource)envContext.lookup("java:/comp/env/jdbc/droppod");
            Connection con = ds.getConnection();
                         
            pst = con
            		.prepareStatement("select * from droppod.users where username=? and password=?");
            pst.setString(1, name);
            pst.setString(2, pass);
            rs = pst.executeQuery();
            status = rs.next();
            

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return status;
    }
}
