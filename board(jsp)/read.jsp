<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html> <body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

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
	int idx = Integer.parseInt(request.getParameter("idx"));
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select title from pan where idx = "+ idx);
	
%>
<h2>□<% while(rs.next()) { out.print(rs.getString(1)); }; %>□</h2>


<% 
	
	ResultSet rs2 = stmt.executeQuery("select count from pan where idx = "+ idx);
	int count = 0;
	while(rs2.next()) { count = rs2.getInt(1); }	
	count += 1;
	stmt.executeUpdate("update pan set count="+count+" where idx="+idx);
	
	ResultSet rs3 = stmt.executeQuery("select * from pan where idx = "+ idx);
	while(rs3.next()) {
		out.print("글쓴이: " + rs3.getString(2) + " | 날짜: " + rs3.getString(5) + " | 조회수: " + rs3.getInt(8));
		//out.print("<br>ip : " + rs3.getString(6) + "<br>";
		out.print("<h3>" + rs3.getString(4) + "</h3><p>");
	}
	ResultSet rs4 = stmt.executeQuery("select name, cntnt, date, idx from comm where num = "+ idx + " order by idx desc");

	out.print("<p><b>[댓글]</b> <br>");
	while(rs4.next()) {
		out.print("<b>" + rs4.getString(1) + "</b> : " + rs4.getString(2) + "<br><span style='font-size:0.8em;'>[" + rs4.getString(3) + "]</span>");%>
		<a href='cpwtp.jsp?idx=<%=idx  %>&case=1&cidx=<%=rs4.getInt(4) %>' style='font-size:0.8em;'>[수정]</a>
		<a href='cpwtp.jsp?idx=<%=idx  %>&case=0&cidx=<%=rs4.getInt(4) %>' style='font-size:0.8em;'>[삭제]</a><p>
	
	<%}

	
%>
	

<p>
<a href="board.jsp">[목록으로]</a><br>
<a href = 'pwtp.jsp?idx=<%= idx %>&case=1'>[수정]</a><br>
<a href = 'pwtp.jsp?idx=<%= idx %>&case=0'>[삭제]</a><p>
<b>[댓글 입력]</b>
<form action='comment.jsp?idx=<%= idx%>' method=post>
			<input type="text" name="comm_name" size="15" placeholder="아이디">
			<input type="password" name="comm_pw" size="15" placeholder="비밀번호">
			<div style="margin-top:10px;">
				<textarea name="comm_cntnt" cols="38" rows="5"></textarea>
				<input type="submit">
			</div>
		</form>
</body>
</html>
