package communication;
import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import logic.Context;
import model.Log;
import model.Measure;

@WebServlet(
    name = "HelloAppEngine",
    urlPatterns = {"/board"}
)
public class BoardServlet extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response) 
      throws IOException {
	  
	  String command = request.getParameter("cmd");
	  if (command ==null) return;
	  switch(command){
	 
		  case "measure":
			  Context.AddMeasure(request);
			  break;
			  
		  case "log":
			  Context.AddLogEntry(request, response);
			  break;
	  }
  }
}