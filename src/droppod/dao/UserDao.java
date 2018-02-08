package droppod.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class UserDao {
public static boolean add(String name, String pass, String email){
Connection conn = null;
boolean status = false;
PreparedStatement pst = null;
ResultSet rs = null;

String url = "jdbc:mysql://localhost:3306/";
String dbName = "droppod";
String driver = "com.mysql.jdbc.Driver";
String userName = "root";
String password = "Zisvo_5M";
int a = 0;
try {
	
	Context envContext = new InitialContext();
    Context initContext  = (Context)envContext.lookup("java:/comp/env");
    DataSource ds = (DataSource)initContext.lookup("jdbc/droppod");
    //DataSource ds = (DataSource)envContext.lookup("java:/comp/env/jdbc/droppod");
    conn = ds.getConnection();
	

	pst = conn.prepareStatement("insert into droppod.users"+"(username,password,email,validated) values"+"(?,?,?,?)");
	pst.setString(1, name);
	pst.setString(2, pass);
	pst.setString(3, email);
	pst.setInt(4, 0);
	a = pst.executeUpdate();

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
	if(a==1) {
		return true;
	}else {
		return false;
	}
}
}
