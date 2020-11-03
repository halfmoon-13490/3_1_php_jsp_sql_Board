<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html> 
<style>
	#dv {
		text-align: center;
	}
	table {
    border: 1px solid #444444;
	border-collapse: collapse;
	text-align: center;
 	 }
	th, td {
    border: 1px solid #444444;
	  }
</style>
<body>
<div id="dv">
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%! 
	
%>

<%

	String url="jdbc:mysql://localhost:3306/kimhyeg1021";
	String id = "kimhyeg1021";
	String pssw = "KSkimhyeg1021M";
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pssw);

	}catch(Exception e){
		out.println("failed");	
		out.println(e.getMessage());	
	}

		out.print("<h2>검색 현황</h2>");
		

		pstmt = conn.prepareStatement("select ip, kwd, date from search order by idx desc");
		rs = pstmt.executeQuery();
		
		out.print("<table align ='center'>");
		out.println("<tr bgcolor=lightblue>");
		out.println("<th style='width: 130px'>ip</th><th style='width: 700px'>검색 조건</th><th style='width: 160px'>검색 시간</th>");
		out.println("</tr><br>");
		while(rs.next()) {
			out.print("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td></tr>");
		}
		out.print("</table><p>");
	
%>
<p>
<a href='data_main.jsp'>[메인 화면]</a>
</div>
</body>
</html>
