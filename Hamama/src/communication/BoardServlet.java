package communication;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import logic.Context;

@WebServlet(name = "HelloAppEngine", urlPatterns = { "/board" })
public class BoardServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		Context ctx;
		try {
			ctx = new Context(request, response);
		} catch (Exception e) {
			System.out.println("Fatal error: the server is not functioning yet.");
			e.printStackTrace();
			return;
		}
		String command = request.getParameter("cmd");
		if (command == null)
			return;
		switch (command) {
		case "measure":
			ctx.AddMeasure();
			break;

		case "log":
			ctx.AddLogEntry();
			break;
		}
	}
}