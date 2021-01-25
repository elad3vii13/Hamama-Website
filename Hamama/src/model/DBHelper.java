package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class DBHelper {
	static Connection con;
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			//			String url= String.format("jdbc:mysql://35.228.172.36:3306/sotz");
			//			con = DriverManager.getConnection(url, "elad", "Eladl1254");

			String url= String.format("jdbc:mysql://localhost:3306/sotz?serverTimezone=Asia/Jerusalem");
			con = DriverManager.getConnection(url, "root", "1313");

		} catch (SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void addUser (String name) {
		String sqlString = "INSERT INTO  users" + " (name)" 
				+ "VALUES ('"+ name + "')";
		try {
			Statement statement = con.createStatement();
			statement.executeUpdate(sqlString);
			statement.close();
		} catch(SQLException ex) {System.out.println("SQLException: " + ex.getMessage());}			

	}

	public void addMeasure (Measure measure) {

		String sqlString = "INSERT INTO  measures" + " (time, value, sid)" 
				+ "VALUES ("+ measure.getTime()+ "," + measure.getValue() +", " + measure.getSid() +")";
		try {
			Statement statement = con.createStatement();
			statement.executeUpdate(sqlString);
			statement.close();
		} catch(SQLException ex) {System.out.println("SQLException: " + ex.getMessage());}			

	}

	public void addLogEntry (Log log) throws Exception {

		String sqlString = "INSERT INTO  log" + " (time, priority, message, sid)" 
				+ "VALUES ("+ log.getTime()+ ",'" + log.getpriority() +"', '" + log.getMessage()+ "', " + log.getSid() + ")";
		try {
			Statement statement = con.createStatement();
			statement.executeUpdate(sqlString);
			statement.close();
		} catch(SQLException ex) {
			System.out.println("SQLException: " + ex.getMessage());
			throw new Exception("bad new-Log command");
			}			
	}
	
	public ArrayList<Measure> getMeasures(int sid, long from, long to){ 
		Statement statement; 
		String	sqlString = "SELECT * FROM measures where sid=" + sid +
									" and time between " + from + " and " + to + " order by time ASC";
		try {
			statement = con.createStatement(); ResultSet rs=statement.executeQuery(sqlString);
			ArrayList<Measure> result = new ArrayList<Measure>();
			while(rs.next()) {
				Measure m = new Measure();
				m.setTime(rs.getLong(rs.findColumn("time")));
				m.setValue(rs.getDouble(rs.findColumn("value")));
			//	m.setSid(rs.getInt(rs.findColumn("sid"))); 
				result.add(m);
			}
			statement.close(); 
			return result;
		} 
		catch(SQLException ex) {
			System.out.println("SQLException: " + ex.getMessage()); 
			return null; 
		}

	} 
	
	public HashMap<Integer, String> getAllSensorsNames(){
		Statement statement; 
		String	sqlString = "SELECT * FROM sensors" ;
		try {
			statement = con.createStatement(); 
			ResultSet rs=statement.executeQuery(sqlString);
			HashMap<Integer, String>result = new HashMap<Integer, String>();
			while (rs.next()) {
				result.put(rs.getInt("id"), rs.getString("displayName"));
			}
			return result;
		}catch(SQLException ex) {
			System.out.println("SQLException: " + ex.getMessage()); 
			return null; 
		}
			
	}
		
	public ArrayList<Log> getLogEntries(String sid, long from, long to, String priority){ 
		Statement statement; 
		String filter ="where time between " + from + " and " + to;
		if (sid != null)
			filter += " and sid=" + sid;
		if (priority != null)
			filter += " and priority= '" + priority + "'";
		String	sqlString = "SELECT * FROM log " + filter + " order by time ASC";
		try {
			statement = con.createStatement(); ResultSet rs=statement.executeQuery(sqlString);
			ArrayList<Log> result = new ArrayList<Log>();
			while(rs.next()) {
				Log m = new Log();
				m.setTime(rs.getLong(rs.findColumn("time")));
				m.setSid(rs.getInt(rs.findColumn("sid"))); 
				m.setpriority(rs.getString(rs.findColumn("priority")));
				m.setMessage(rs.getString(rs.findColumn("message")));
				result.add(m);
			}
			statement.close(); 
			return result;
		} 
		catch(SQLException ex) {
			System.out.println("SQLException: " + ex.getMessage()); 
			return null; 
		}

	}
	
	public Sensor getSensorProperties(int sid) {
		Statement statement; 
		String	sqlString = "SELECT * FROM sensors where id=" + sid ;
		try {
			statement = con.createStatement(); 
			ResultSet rs=statement.executeQuery(sqlString);
			if (rs.next()) {
				Sensor s = new Sensor();
				s.setId(rs.getInt("id"));
				s.setName(rs.getNString("name"));
				s.setUnits(rs.getNString("units"));
				return s;
			}
			else
				return null;
		}
		catch(SQLException ex) {
			System.out.println("SQLException: " + ex.getMessage()); 
			return null; 
		}
	}
	
	public ArrayList<Sensor> getAllSensors() {
		Statement statement; 
		String	sqlString = "SELECT * FROM sensors" ;
		try {
			statement = con.createStatement(); 
			ResultSet rs=statement.executeQuery(sqlString);
			ArrayList<Sensor> result = new ArrayList<Sensor>();
			while (rs.next()) {
				Sensor s = new Sensor();
				s.setId(rs.getInt("id"));
				s.setDisplayName(rs.getString("displayName"));
				s.setName(rs.getNString("name"));
				s.setUnits(rs.getNString("units"));
				result.add(s);
			}
			return result;
		}
		catch(SQLException ex) {
			System.out.println("SQLException: " + ex.getMessage()); 
			return null; 
		}
	}
}

