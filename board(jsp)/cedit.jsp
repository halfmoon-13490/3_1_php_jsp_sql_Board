<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html> <body>
<h2>댓글 수정</h2>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
	int cidx = Integer.parseInt(request.getParameter("cidx"));
%>
<form action='cedit.jsp?cidx=<%= cidx %>' method=post>
	내용 입력: <br><textarea name="comm_cntnt" cols="38" rows="5"></textarea><p>
				<input type="submit"> <input type=reset>
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
	Statement stmt = null;
	ResultSet rs = null;

	java.util.Date date = new java.util.Date();
	SimpleDateFormat f1;
	f1 = new SimpleDateFormat("yyyy/M/d  HH:mm:ss",  Locale.KOREA);

	String date1 = f1.format(date) + "";

	String ip = request.getRemoteAddr();
	out.print("IP: " + ip + "<br>날짜: " + date1);
	
	String cntnt = "";


	if(request.getParameter("comm_cntnt") == null) {
		cntnt = "";
	}else {
		cntnt = request.getParameter("comm_cntnt");
	}
	
	int num = 0;
	String comp = "";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pssw);

	}catch(Exception e){
		out.println("failed");
		out.println(e.getMessage());	
	}
	stmt = conn.createStatement();
	rs = stmt.executeQuery("select num from comm where idx =" + cidx);
	while(rs.next()) { num = rs.getInt(1); }

	if(!comp.equals(cntnt)) {
		pstmt = conn.prepareStatement("update comm set cntnt = ?, date = ? where idx= ?");
		pstmt.setString(1, cntnt);
		pstmt.setString(2, date1);
		pstmt.setInt(3, cidx);

		try {
			pstmt.executeUpdate();
		}catch(Exception e){
			out.println("failed");
			out.println(e.getMessage());	
		}		

		%> <script>alert('수정에 성공했습니다.'); location.href='read.jsp?idx=<%=num %>';</script>
	<%} else {%>
		<script> alert('제목, 내용을 입력해주세요.');</script>
	<%}
	
%>
<p>
<a href="board.jsp">[목록으로]</a> 
<a href='read.jsp?idx=<%=num %>'>[게시글로]</a> 
</body>
</html>
