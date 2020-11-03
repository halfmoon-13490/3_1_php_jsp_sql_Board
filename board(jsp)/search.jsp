<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html> <body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<style>
	#dv {
		text-align: center;
	}
	table {
    border: 1px solid #444444;
	border-collapse: collapse;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
 	 }
	th, td {
    border: 1px solid #444444;
	  }
</style>
<%
	String str = request.getParameter("select");
	String sch = request.getParameter("search");
	String txt = "";
	if(str.equals("title")) {
		txt = "제목";
	} else if(str.equals("name")) {
		txt = "글쓴이";
	} else if(str.equals("cntnt")) {
		txt = "내용";
	} else if(str.equals("idx")) {
		txt = "번호";
	} 
%>
<div id='dv'>
<h2><%= txt %>에서 '<%= sch %>' 검색 결과</h2>
<table>
<% 
	String url="jdbc:mysql://localhost:3306/kimhyeg1021";
	String id = "kimhyeg1021";
	String pw = "KSkimhyeg1021M";
	Connection conn = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);

	}catch(Exception e){
		out.println("failed");
		out.println(e.getMessage());	
	}

	out.println("<tr bgcolor=lightblue>");
	out.println("<th>번호</th><th style='width: 600px'>제목</th><th style='width: 200px'>글쓴이</th><th style='width: 200px'>날짜</th><th>조회수</th>");
	out.println("</tr><br>");

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	Statement stmt = null;
	Statement stmt2 = null;

	String q = "SELECT * FROM pan where " + str + " like '%" + sch + "%' ORDER BY idx DESC";
	stmt2 = conn.createStatement();
	rs = stmt2.executeQuery(q);	

	int cc = 0;

	while(rs.next()){
		stmt = conn.createStatement();
		rs2 = stmt.executeQuery("select count(*) as count from comm where num=" + rs.getInt(1));
		while(rs2.next()){ cc = rs2.getInt(1);}
		
		%><tr>
			<td><%= rs.getInt(1) %></td>
			<td><a href = 'read.jsp?idx=<%=rs.getInt(1) %>'> <%= rs.getString(7) %></a><span style='color:red; font-size:0.8em;'> [<%= cc %>]</span></td>
			<td><%= rs.getString(2) %></td>
			<td><%= rs.getString(5) %></td>
			<td><%= rs.getInt(8) %></td></tr>
	<%}
	
%>
	
</table>
<p><a href="board.jsp">홈으로</a>

<form action="search.jsp" method=get>
	<select name="select">
		<option value="title">제목</option>
		<option value="name">글쓴이</option>
		<option value="cntnt">내용</option>
		<option value="idx">번호</option>
	</select>
	<input type="text" name="search" size="30" required>
	<input type="submit" value="검색">
</form>
</div>
</body>
</html>

