package logic;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DBHelper;
import model.Log;
import model.Measure;
import model.Sensor;

import java.lang.reflect.Type;
import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

public class Util {

	private static DBHelper myDB = new DBHelper();
	
	public static void AddMeasure(HttpServletRequest request) {
		  String value= request.getParameter("value");
		  String time= request.getParameter("time");
		  String sid= request.getParameter("sid");
		  Measure m = new Measure(Long.parseLong(time), Double.parseDouble(value), Integer.parseInt(sid));
		  myDB.addMeasure(m);
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
		  myDB.addLogEntry(log);
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
			ArrayList<Log> list = myDB.getLogEntries(sid, Long.parseLong(from), Long.parseLong(to), priority);
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
		ArrayList<Measure> list = myDB.getMeasures(Integer.parseInt(sid), Long.parseLong(from), Long.parseLong(to));
		Type listType = new TypeToken<ArrayList<Measure>>() {}.getType();
		Gson gson = new Gson(); 
		Sensor sensor = myDB.getSensorProperties(Integer.parseInt(sid));
		JsonObject jsonResult = (JsonObject) gson.toJsonTree(new Sensor(Integer.parseInt(sid), sensor.getName(), sensor.getUnits(), sensor.getDisplayName()));
		String jsonMeasures = gson.toJson(list, listType);
		jsonResult.addProperty("measures", jsonMeasures);
		
		return jsonResult.toString();
	}
	
	public static String getAllSensors(HttpServletRequest request) {
		ArrayList<Sensor> sensors = myDB.getAllSensors();
		Type listType = new TypeToken<ArrayList<Sensor>>() {}.getType();
		Gson gson = new Gson(); 
		String jsonAllSensors = gson.toJson(sensors, listType);
		return jsonAllSensors;
	}
}
