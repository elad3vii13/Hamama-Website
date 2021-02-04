package logic;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import model.Log;
import model.Measure;
import model.MySQLDB;
import model.Sensor;
import model.User;

//This class is a middle layer class between the "communication" layers 
//and the back-end/model/db layers. it provides mainly business logic to
//your web site.
//it has two constructors, one usually used from servlets/listeners modules 
//and the other used from jsp pages

public class Context {
	HttpServletRequest request;
	HttpServletResponse  response;
	HttpSession session;
	ServletContext application;
	PrintWriter out;
	static MySQLDB dbc= new MySQLDB();
	private final String SESSION_KEY_USER= "currentUser";
	private final String SESSION_KEY_MANAGER= "isManager";
	
	public List<User> getAllUseList() {
		return dbc.getAllUsers();
	}
	
	public void deleteUser(String username) {
		dbc.DeleteUser(username);
		try {
			response.sendRedirect("management.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//used mainly from JSP	
	public Context(PageContext pContext) throws Exception {
		this((HttpServletRequest)pContext.getRequest(), 
				(HttpServletResponse)pContext.getResponse());
	}
	
	//used mainly from servlets
	public Context(HttpServletRequest request, HttpServletResponse response) throws Exception {
		this.request = request;
		
		this.response = response;
		this.session = request.getSession();
		this.application = this.session.getServletContext();
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			this.out = response.getWriter();
			
			if (dbc.IsDbConnected() == false) {
				throw(new Exception("no db connection"));
			}
		} catch (IOException e) {};
		
	}
	
	public void insertAlertDlg(String msg, String forwardToPage){
		out.write("<script charset=\"UTF-8\">");
		out.write("alert('" + msg + "');");
		//out.write("setTimeout(function(){window.location.href='secondpage.jsp'},1000);");
		if (forwardToPage!= null)
			out.write("window.location.href='"+ forwardToPage + "';");
		out.write("</script>");
	}
	
	public void handleLogout(){
		this.session.removeAttribute(SESSION_KEY_USER);
		try {
			response.sendRedirect("home.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public boolean isLoggedIn(){
		return (this.session.getAttribute(SESSION_KEY_USER)!= null);
	}
	
	public boolean isManager(){
		User u = (User) this.session.getAttribute(SESSION_KEY_USER);
		return (u!= null) &&  u.getRole().equals(User.MGR_ROLE);
	}
	
	public String getCurrentUserName() {
		User u = (User) this.session.getAttribute(SESSION_KEY_USER);
		return (u==null)?"אורח": u.getNickName();
	}
	
	public void handleLogin() {
		String nickname= request.getParameter("nickname");
		String password= request.getParameter("password");
		try {
			User u = dbc.UserAuthenticate(nickname, password);
			if(u!=null) {
				this.session.setAttribute(SESSION_KEY_USER, u);
				String url = "home.jsp?name=" + URLEncoder.encode(nickname, "UTF-8");
				response.sendRedirect(url);
				//you might need to encode the url in some unresolved cases where sessionID needs to be enforced
				//response.sendRedirect(response.encodeRedirectURL(url));
			}
			else {
				 request.setAttribute("error",  "×©×� ×”×ž×©×ª×ž×© ×�×• ×”×¡×™×¡×ž×� ×�×™× ×� × ×›×•× ×™×�, ×�× ×� × ×¡×” ×©×•×‘");
				 request.getRequestDispatcher("login.jsp").forward(request, response);
		
			}
		} catch (IOException | ServletException e) {
			e.printStackTrace();
		} 
	}
	public void handleRegistration() {
		String nickname= request.getParameter("nickname");
		if (userCanBeRegistered(nickname)){
			dbc.AddNewUser(userFromRequest());
			handleLogin();
		}
		else {
			request.setAttribute("error", "×©×� ×ž×©×ª×ž×© ×–×” ×›×‘×¨ ×‘×©×™×ž×•×©, ×�× ×� ×”×–×Ÿ ×©×� ×�×—×¨");
			try {
				request.getRequestDispatcher("registration.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public String getFieldFromRequest(String key)
	{
		String x = request.getParameter(key);
		return (request.getParameter(key) != null? request.getParameter(key): "");
	}
	
	private User userFromRequest() {
		User u = new User();
		u.setNickName(getFieldFromRequest("nickname"));
		u.setPassword(getFieldFromRequest("password"));
		u.setRole(getFieldFromRequest("role"));
		//update this method to reflect your user object
		return u;
	}
	
	private boolean userCanBeRegistered(String nickname){
		return !dbc.UserExists(nickname);
	}
	
	public void handleUnknownRequest() {
		try {
			response.sendRedirect("home.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}	
	
	public static void AddMeasure(HttpServletRequest request) {
		  String value= request.getParameter("value");
		  String time= request.getParameter("time");
		  String sid= request.getParameter("sid");
		  Measure m = new Measure(Long.parseLong(time), Double.parseDouble(value), Integer.parseInt(sid));
		  dbc.addMeasure(m);
	}
	
	public static void AddLogEntry(HttpServletRequest request, HttpServletResponse response ) {
		 try {
		  String time = request.getParameter("time");
		  String priority = request.getParameter("priority");
		  String message = request.getParameter("message");
		  String sid= request.getParameter("sid");
		  if (time == null || priority == null || message == null || sid == null)
			  throw new Exception("bad new log command");
		  Log log = new Log(Long.parseLong(time), priority, message, Integer.parseInt(sid));
		  dbc.addLogEntry(log);
		  response.setStatus(HttpServletResponse.SC_OK);
		  
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		}
	}
	
	public static void getLogEntries(HttpServletRequest request, HttpServletResponse response) {
		try {
			String sid = request.getParameter("sid");
			String from = request.getParameter("from");
			String to = request.getParameter("to");
			String priority = request.getParameter("priority");
			 if (from == null || to == null)
				  throw new Exception("bad get log command");
			 
			 HashMap<Integer, String> sensors = dbc.getAllSensorsNames();
			 
			ArrayList<Log> list = dbc.getLogEntries(sid, Long.parseLong(from), Long.parseLong(to), priority);
			Type listType = new TypeToken<ArrayList<Log>>() {}.getType();
			Gson gson = new Gson(); 
			String jsonResult = gson.toJson(list, listType);
			response.getWriter().print(jsonResult.toString());
		}catch (Exception e) {
			System.out.println(e.getMessage());
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		}
	}
	
	public static String getMeasures(HttpServletRequest request) {
		String sid = request.getParameter("sid");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		ArrayList<Measure> list = dbc.getMeasures(Integer.parseInt(sid), Long.parseLong(from), Long.parseLong(to));
		Type listType = new TypeToken<ArrayList<Measure>>() {}.getType();
		Gson gson = new Gson(); 
		Sensor sensor = dbc.getSensorProperties(Integer.parseInt(sid));
		JsonObject jsonResult = (JsonObject) gson.toJsonTree(new Sensor(Integer.parseInt(sid), sensor.getName(), sensor.getUnits(), sensor.getDisplayName()));
		String jsonMeasures = gson.toJson(list, listType);
		jsonResult.addProperty("measures", jsonMeasures);
		
		return jsonResult.toString();
	}
	
	public static String getAllSensors(HttpServletRequest request) {
		ArrayList<Sensor> sensors = dbc.getAllSensors();
		Type listType = new TypeToken<ArrayList<Sensor>>() {}.getType();
		Gson gson = new Gson(); 
		String jsonAllSensors = gson.toJson(sensors, listType);
		return jsonAllSensors;
	}
	
}
