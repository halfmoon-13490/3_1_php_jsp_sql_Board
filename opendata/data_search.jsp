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
	public boolean isNumeric(String s) {
		try {
      		Double.parseDouble(s);
     		return true;
  		} catch(NumberFormatException e) {
      		return false;
  		}
	}

	public boolean chkInp(String[] cb, String[] inp)	{
		for(int i = 0; i < cb.length; i++) {
			int dum = Integer.parseInt(cb[i]);
			if(inp[dum].equals("") || !isNumeric(inp[dum])) {
				return false;
			} 
		} return true;
	} 
%>

<%

	String url="jdbc:mysql://localhost:3306/kimhyeg1021";
	String id = "kimhyeg1021";
	String pssw = "KSkimhyeg1021M";
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	
	String[] cb = request.getParameterValues("check");

	String[] inp = {"", "", "", "", "", ""};
	String[] radio = {"", "", "", "", "", ""};
	String[] colName = {"주의보 발령횟수 ", "주의보 발령일수 " , "경보 발령횟수 ", "경보 발령일수 " , "관측일수 ", "최대농도(㎍/㎥/시) "};
	int dum = 0;
	
	java.util.Date date = new java.util.Date();	
	SimpleDateFormat f1;
	f1 = new SimpleDateFormat("yyyy/M/d  HH:mm:ss",  Locale.KOREA);
	String date1 = f1.format(date) + "";

	String ip = request.getRemoteAddr();
	
	if(request.getParameter("check") != null) {
		for(int i = 0; i < cb.length; i++) {
			dum = Integer.parseInt(cb[i]);
			inp[dum] = request.getParameter(cb[i]);
		}
	} 
	

	if(request.getParameter("check") == null || !chkInp(cb, inp)) {
		%><script> alert('검색 조건을 충족하여 검색을 실행해주십시오.'); location.href='data_search_main.jsp';</script><%
	} else {	
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pssw);

		}catch(Exception e){
			out.println("failed");
			out.println(e.getMessage());	
		}
	

		for(int i = 0; i < radio.length; i++) {
			String tt = "r" + i;
			radio[i] = request.getParameter(tt);
		}
		

		String q = "select * from data where ";
		String q2 = "update count set cnt = cnt +1 where col = ";
		String q3 = "insert into search (ip, kwd, date) values(?, ?, ?)";
		String kwd = "";
		String h = "";
	
		for(int i = 0; i < cb.length; i++) {
			dum = Integer.parseInt(cb[i]);
			if(cb[i].equals("0")) {
				h = "jh";
				q += h + radio[dum] + inp[dum] + " and ";
				kwd += colName[dum] + radio[dum] + " " + inp[dum] + " / ";
				pstmt2 = conn.prepareStatement(q2 + 0);
				pstmt2.executeUpdate();
			} else if(cb[i].equals("1")) {
				h = "ji";
				q += h + radio[dum] + inp[dum] + " and ";
				kwd += colName[dum] + radio[dum] + " " + inp[dum] + " / ";
				pstmt2 = conn.prepareStatement(q2 + 1);
				pstmt2.executeUpdate();
			} else if(cb[i].equals("2")) {
				h = "gh";
				q += h + radio[dum] + inp[dum] + " and ";
				kwd += colName[dum] + radio[dum] + " " + inp[dum] + " / ";
				pstmt2 = conn.prepareStatement(q2 + 2);
				pstmt2.executeUpdate();
			} else if(cb[i].equals("3")) {
				h = "gi";
				q += h + radio[dum] + inp[dum] + " and ";
				kwd += colName[dum] + radio[dum] + " " + inp[dum] + " / ";
				pstmt2 = conn.prepareStatement(q2 + 3);
				pstmt2.executeUpdate();
			} else if(cb[i].equals("4")) {
				h = "gc";
				q += h + radio[dum] + inp[dum] + " and ";
				kwd += colName[dum] + radio[dum] + " " + inp[dum] + " / ";
				pstmt2 = conn.prepareStatement(q2 + 4);
				pstmt2.executeUpdate();
			} else if(cb[i].equals("5")) {
				h = "cn";
				q += h + radio[dum] + inp[dum] + " and ";
				kwd += colName[dum] + radio[dum] + " " + inp[dum] + " / ";
				pstmt2 = conn.prepareStatement(q2 + 5);
				pstmt2.executeUpdate();
			} 
		}
		
		q = q.substring(0, q.length()-5).trim();
		kwd = kwd.substring(0, kwd.length()-3).trim();
	
		out.print("<h2>검색 조건 : " + kwd + "</h2>");
		out.print("<b>검색자 ip주소: " + ip + "</b><br>");

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
		
		pstmt = conn.prepareStatement(q3);
		pstmt.setString(1, ip);
		pstmt.setString(2, kwd);
		pstmt.setString(3, date1);
		pstmt.executeUpdate();

		pstmt = conn.prepareStatement("select * from count order by cnt desc limit 3");
		rs = pstmt.executeQuery();
		int grade = 1;
		
		out.print("<p><h3>○주요 검색 기준 순위○</h3>");
		
		while(rs.next()) {
			out.print(grade + "위: " + colName[rs.getInt(1)] + " / " + rs.getInt(2)+ "회 <br>");
			grade += 1;
		}
		
	}
	
%>
<p>
<a href='data_main.jsp'>[메인 화면]</a>
<a href='data_search_main.jsp'>[돌아가기]</a>
</div>
</body>
</html>
