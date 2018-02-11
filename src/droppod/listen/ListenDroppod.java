package droppod.listen;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import droppod.models.EpisodeModel;

public class ListenDroppod {
    public static List<EpisodeModel> getEpisodes(String uuid) {        

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        List<EpisodeModel> rows = new ArrayList<EpisodeModel>();
        
        //String filename = "config.properties";
        //Properties prop = new Properties();
        //try {
		//	prop.load(Thread.currentThread().getContextClassLoader().getResourceAsStream(filename));
		//} catch (IOException e1) {
		//	e1.printStackTrace();
			/* Since we cant connnect to the db, we wont be able to authenticate
			 * therefore, we return false. */
			//return rows;
		//}

        try {

        	Context envContext = new InitialContext();
            Context initContext  = (Context)envContext.lookup("java:/comp/env");
            DataSource ds = (DataSource)initContext.lookup("jdbc/droppod");
            //DataSource ds = (DataSource)envContext.lookup("java:/comp/env/jdbc/droppod");
            Connection con = ds.getConnection();
                         
            pst = con
            		.prepareStatement("SELECT * FROM droppod.episodes WHERE podcast_id IN "
            				+ "(SELECT id FROM droppod.podcasts WHERE uuid=?)");
            pst.setString(1, uuid);
            rs = pst.executeQuery();
            
            /* Get all the rows from the result set and put them in an ArrayList so
             * that we can close the DB connection. */
            while(rs.next()) {
            	EpisodeModel episode = new EpisodeModel();
            	episode.setName(rs.getString("name"));
            	episode.setDescription(rs.getString("description"));
            	episode.setUrl(rs.getURL("url"));
            	rows.add(episode);
            }
            

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
        return rows;
    }
}