<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html> <body>
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

	public boolean chkInp(String[] inp)	{
		for(int i = 0; i < 7; i++) {
			if(!isNumeric(inp[i])) {
				return false;
			} 
		} return true;
	} 
%>
<h2>서울시 연도별 황사 경보 발령 현황 조회</h2>
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

	
	String[] test = new String[7];
	int arr[] = new int[7];
	
	test[0] = request.getParameter("select");

	for(int i = 1; i < 7; i++) {
		if(request.getParameter(i+"").equals("")) {
			test[i] = "0";
		}
		test[i] = request.getParameter(i+"");
	}
 

	if(!chkInp(test)) {
		%><script> alert('수정에 실패하였습니다. 조건을 확인하여 주십시오.'); location.href='data_edit_main.jsp';</script><%
	} else { 
		for(int i = 0; i < 7; i++) {
			arr[i] = Integer.parseInt(test[i]);
		}
	
		pstmt = conn.prepareStatement("update data set jh = ?, ji = ?, gh = ?, gi = ?, gc = ?, cn = ? where nd = ?");
	
		pstmt.setInt(1, arr[1]);
		pstmt.setInt(2, arr[2]);
		pstmt.setInt(3, arr[3]);
		pstmt.setInt(4, arr[4]);
		pstmt.setInt(5, arr[5]);
		pstmt.setInt(6, arr[6]);
		pstmt.setInt(7, arr[0]);


		try {
			pstmt.executeUpdate();
			%><script> alert('수정에 성공하였습니다.'); location.href='data_edit_main.jsp';</script><%
		}catch(Exception e){
			%><script> alert('수정에 실패하였습니다. 조건을 확인하여 주십시오.'); location.href='data_edit_main.jsp';</script><%
		}
	}	
%>
</body>
</html>
