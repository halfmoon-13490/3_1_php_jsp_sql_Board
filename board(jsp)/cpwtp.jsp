<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html> <body>
<h2>게시물 아이디/비밀번호 입력</h2>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
	int cases = Integer.parseInt(request.getParameter("case"));
	int idx = Integer.parseInt(request.getParameter("idx"));
	int cidx = Integer.parseInt(request.getParameter("cidx"));
%>
<form action='cpwtp.jsp?idx=<%= idx %>&cidx=<%= cidx %>&case=<%= cases%>' method=post>
	아이디: <input type="text" name="name"><p>
 	비밀번호: <input type="password" name="pw"><p>
 <input type=submit> <input type=reset>
</form>

<% 	
	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	String url="jdbc:mysql://localhost:3306/kimhyeg1021";
	String id = "kimhyeg1021";
	String pssw = "KSkimhyeg1021M";
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pssw);

	}catch(Exception e){
		out.println("failed");
		out.println(e.getMessage());	
	}
	
	String tname = "";
	String tpw = "";

	stmt = conn.createStatement();
	rs = stmt.executeQuery("select name, AES_DECRYPT(UNHEX(pw), 'test') as pw from comm where idx =" + cidx);
	while(rs.next()) {
			tname = rs.getString(1);
			tpw = rs.getString(2);
	}

	if(cases == 0) {
		if(tname.equals(name) && tpw.equals(pw)) {
			stmt = conn.createStatement();
			stmt.executeUpdate("delete from comm where idx =" + cidx); %>
			<script>alert('삭제를 완료 하였습니다.'); location.href='read.jsp?idx=<%=idx %>';</script>
		<%}
		else {%>
			<script>alert('알맞은 아이디와 비밀번호를 입력해주세요.');</script>
		<%}
	} else if(cases == 1) {
		if(tname.equals(name) && tpw.equals(pw)) { %>
			<script>location.href='cedit.jsp?cidx=<%=cidx %>';</script>
		<%}
		else {%>
			<script>alert('알맞은 아이디와 비밀번호를 입력해주세요.');</script>
		<%}
	
	}
	
%>

</body>
</html>
