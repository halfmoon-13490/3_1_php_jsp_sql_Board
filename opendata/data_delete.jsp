<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html> <body>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
	String url="jdbc:mysql://localhost:3306/kimhyeg1021";
	String id = "kimhyeg1021";
	String pssw = "KSkimhyeg1021M";
	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pssw);

	}catch(Exception e){
		out.println("failed");	
		out.println(e.getMessage());	
	}

	
	String q = "delete from data where nd = ?";
	
	pstmt = conn.prepareStatement(q);
	pstmt.setString(1, request.getParameter("select"));

	try {
		pstmt.executeUpdate();
		%><script> alert('삭제에 성공하였습니다.'); location.href='data_delete_main.jsp';</script><%
	}catch(Exception e){
		%><script> alert('삭제에 실패하였습니다. 조건을 확인하여 주십시오.'); location.href='data_delete_main.jsp';</script><%
	}
%>
</body>
</html>
