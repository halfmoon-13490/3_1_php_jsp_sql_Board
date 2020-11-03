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

<h2>신규 현황 삽입</h2>
<%
	String url="jdbc:mysql://localhost:3306/kimhyeg1021";
	String id = "kimhyeg1021";
	String pssw = "KSkimhyeg1021M";
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pssw);

	}catch(Exception e){
		out.println("failed");	
		out.println(e.getMessage());	
	}

	String q = "select * from data";
	pstmt = conn.prepareStatement(q);
	rs = pstmt.executeQuery();

	out.print("<table align ='center'>");
		out.println("<tr bgcolor=lightblue>");
		out.println("<th style='width: 55px'>년도</th><th style='width: 140px'>주의보 발령횟수</th><th style='width: 140px'>주의보 발령일수</th><th style='width: 120px'>경보 발령일수</th><th style='width: 120px'>경보 발령일수</th><th style='width: 80px'>관측일수</th><th style='width: 180px'>최대농도(㎍/㎥/시)</th>");
		out.println("</tr><br>");
		while(rs.next()) {
			out.print("<tr><td>" + rs.getInt(1) + "</td><td>" + rs.getInt(2) + "</td><td>" + rs.getInt(3) + "</td><td>" + rs.getInt(4) + "</td><td>" + rs.getInt(5) + "</td><td>" + rs.getInt(6) +  "</td><td>" + rs.getInt(7) + "</td></tr>");
		}
		out.print("</table><p>");

%>

	<h3>조건 입력</h3>
	<form action='data_insert.jsp' method=post>
		년도: <input type="text" value=0 name='0' ><br>
		주의보 발령횟수: <input type="text" value=0 name='1'><br>
		주의보 발령일수: <input type="text" value=0 name='2'><br>
		경보 발령횟수: <input type="text" value=0 name='3'><br>
		경보 발령일수: <input type="text" value=0 name='4'><br>
		관측일수: <input type="text" value=0 name='5'><br>
		최대농도(㎍/㎥/시): <input type="text" value=0 name='6'><p>
		<input type=submit> <input type=reset>
	</form> 
	<p>
	<a href='data_main.jsp'>[메인 화면]</a>
</div>

</body>
</html>
