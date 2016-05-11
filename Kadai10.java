/*
 * クラス名　：SampleServlet01.java
 * 
 * 作成日　：2006/12/01
 * 作成者　：アイオステクノロジー
 * 最終更新日：2006/12/01
 * 最終更新者：アイオステクノロジー
 *
 */
import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * 簡単なサーブレットです。
 */
public class Kadai10 extends HttpServlet{

    public void doGet (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
		response.setContentType("text/html; charset=EUC-JP");
      	PrintWriter writer=response.getWriter();
      	writer.println("<html><head><title>sample</title></head>");
      	writer.println("<body>こんにちは</body></html>");
	}
	}
    public void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        doGet(request,response);
    }
}
