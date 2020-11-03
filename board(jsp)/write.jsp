<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html> <body>
<h2>게시물 작성</h2>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<form action="write.jsp" method=post>
	제목: <input type="text" name="title"><br>
	아이디: <input type="text" name="name"><br>
	비밀번호: <input type="password" name="pw"><br>
 	내용: <br><textarea name="cntnt" cols="50" rows="20"></textarea><br>
<%

	java.util.Date date = new java.util.Date();
	SimpleDateFormat f1;
	f1 = new SimpleDateFormat("yyyy/M/d  HH:mm:ss",  Locale.KOREA);
	String date1 = f1.format(date) + "";

	String ip = request.getRemoteAddr();

	out.print("IP: " + ip + "<br>날짜: " + date1 + "<p>");

 %>
	<input type=hidden name="date" value='<%=date1 %>'><br>
 	<input type=hidden name="ip" value='<%=ip %>'>
 	<input type=submit> <input type=reset>
</form>

<% 	
	String url="jdbc:mysql://localhost:3306/kimhyeg1021";
	String id = "kimhyeg1021";
	String pssw = "KSkimhyeg1021M";
	Connection conn = null;
	PreparedStatement pstmt = null;

	

	String name = request.getParameter("name");
	String pw = request.getParameter("pw");

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

	if(!comp.equals(title) && !comp.equals(cntnt) && !comp.equals(id) && !comp.equals(title)) {
		pstmt = conn.prepareStatement("insert into pan(name, pw, cntnt, date, ip, title, count) VALUES(?, HEX(AES_ENCRYPT(?, 'test')), ?, ?, ?, ?, 0)");
		pstmt.setString(1, name);
		pstmt.setString(2, pw);
		pstmt.setString(3, cntnt);
		pstmt.setString(4, date1);
		pstmt.setString(5, ip);
		pstmt.setString(6, title);

		try {
			pstmt.executeUpdate();
		}catch(Exception e){
			out.println("failed");
			out.println(e.getMessage());	
		}

		%> <script> alert('글쓰기에 성공했습니다.'); location.href='board.jsp';</script>
	<%} else {%>
		<script> alert('아이디, 제목, 내용, 비밀번호를 입력해주세요.');</script>
	<%}
	
%>
<p>
<a href="board.jsp">[돌아가기]</a> 
</body>
</html>
