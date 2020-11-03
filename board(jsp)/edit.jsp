<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html> <body>
<h2>게시물 수정</h2>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
	int idx = Integer.parseInt(request.getParameter("idx"));
%>
<form action='edit.jsp?idx=<%= idx %>' method=post>
	제목: <input type="text" name="title"><br>
	내용: <br><textarea name="cntnt" cols="50" rows="20"></textarea><br>
	<input type=submit> <input type=reset>
</form>
<p>
<% 	
	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	String url="jdbc:mysql://localhost:3306/kimhyeg1021";
	String id = "kimhyeg1021";
	String pssw = "KSkimhyeg1021M";
	Connection conn = null;
	PreparedStatement pstmt = null;

	java.util.Date date = new java.util.Date();
	SimpleDateFormat f1;
	f1 = new SimpleDateFormat("yyyy/M/d  HH:mm:ss",  Locale.KOREA);

	String date1 = f1.format(date) + "";

	String ip = request.getRemoteAddr();
	out.print("IP: " + ip + "<br>날짜: " + date1);
	
	String title = "";
	String cntnt = "";

	if(request.getParameter("title") == null) {
		title = "";
	}else {
		title = request.getParameter("title");
	}
	
	if(request.getParameter("cntnt") == null) {
		cntnt = "";
	}else {
		cntnt = request.getParameter("cntnt");
	}
	
	
	String comp = "";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pssw);

	}catch(Exception e){
		out.println("failed");
		out.println(e.getMessage());	
	}

	if(!comp.equals(title) && !comp.equals(cntnt)) {
		pstmt = conn.prepareStatement("update pan set cntnt = ?, title = ?, ip = ?, date = ? where idx= ?");
		pstmt.setString(1, cntnt);
		pstmt.setString(2, title);
		pstmt.setString(3, ip);
		pstmt.setString(4, date1);
		pstmt.setInt(5, idx);

		try {
			pstmt.executeUpdate();
		}catch(Exception e){
			out.println("failed");
			out.println(e.getMessage());	
		}

		%> <script>alert('수정에 성공했습니다.'); location.href='read.jsp?idx=<%=idx %>';</script>
	<%} else {%>
		<script> alert('제목, 내용을 입력해주세요.');</script>
	<%}
	
%>
<p>
<a href="board.jsp">[목록으로]</a> 
<a href='read.jsp?idx=<%=idx %>'>[게시글로]</a> 
</body>
</html>
