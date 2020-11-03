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
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pssw);

	}catch(Exception e){
		out.println("failed");
		out.println(e.getMessage());	
	}

	int idx = Integer.parseInt(request.getParameter("idx"));
	String name = request.getParameter("comm_name");
	String pw = request.getParameter("comm_pw");
	String cntnt = request.getParameter("comm_cntnt");
	
	java.util.Date date = new java.util.Date();
	SimpleDateFormat f1;
	f1 = new SimpleDateFormat("yyyy/M/d  HH:mm:ss",  Locale.KOREA);

	String date1 = f1.format(date) + "";
	
	PreparedStatement pstmt = null;
	String comp = "";	

	if(!comp.equals(name) && !comp.equals(pw) && !comp.equals(cntnt)) {
		pstmt = conn.prepareStatement("insert into comm(num, name, pw, cntnt, date) VALUES(?, ?, HEX(AES_ENCRYPT(?, 'test')), ?, ?)");
		pstmt.setInt(1, idx);
		pstmt.setString(2, name);
		pstmt.setString(3, pw);
		pstmt.setString(4, cntnt);
		pstmt.setString(5, date1);

		pstmt.executeUpdate();
		
		%> <script>alert('댓글작성에 성공했습니다.'); location.href='read.jsp?idx=<%=idx %>';</script>
	<%} else {%>
		<script> alert('댓글과 아이디,  비밀번호를 입력해주세요.'); location.href='read.jsp?idx=<%=idx %>';</script>
	<%}
	
	
%>
</body>
</html>
