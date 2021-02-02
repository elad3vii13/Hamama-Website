package communication;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import logic.Context;

/**
 * Servlet implementation class MobileServlet
 */
@WebServlet("/mobile")
public class MobileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MobileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		  
		String command = request.getParameter("cmd");
		  if (command ==null) return;
		  switch(command){
		  
			  case "measure":
				  String result = Context.getMeasures(request);
				  
				  response.getWriter().print(result);
				  break;
				  
			  case "sensors":
				  String resultSensors = Context.getAllSensors(request);
				
				  response.setContentType("application/json");
				  response.getWriter().print(resultSensors);
				  break;
				  
			  case "log":
				  Context.getLogEntries(request, response);
				  break;
		  }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
