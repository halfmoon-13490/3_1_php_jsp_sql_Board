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
<h2>서울시 연도별 황사 경보 발령 현황 조회</h2>

	<h3>조건 입력</h3>
	<form action='data_search.jsp' method=post>
		<input type='checkbox' name='check' value='0' /> 주의보 발령횟수: <input type="text" name='0'><p>
		<input type='radio' name='r0' value='=' checked/> 일치
		<input type='radio' name='r0' value='>=' /> 이상
		<input type='radio' name='r0' value='<=' /> 이하<p>
		<input type='checkbox' name='check' value='1' /> 주의보 발령일수: <input type="text" name='1'><p>
		<input type='radio' name='r1' value='=' checked/> 일치
		<input type='radio' name='r1' value='>=' /> 이상
		<input type='radio' name='r1' value='<=' /> 이하<p>
		<input type='checkbox' name='check' value='2' /> 경보 발령횟수: <input type="text" name='2'><p>
		<input type='radio' name='r2' value='=' checked/> 일치
		<input type='radio' name='r2' value='>=' /> 이상
		<input type='radio' name='r2' value='<=' /> 이하<p>
		<input type='checkbox' name='check' value='3' /> 경보 발령일수: <input type="text" name='3'><p>
		<input type='radio' name='r3' value='=' checked/> 일치
		<input type='radio' name='r3' value='>=' /> 이상
		<input type='radio' name='r3' value='<=' /> 이하<p>
		<input type='checkbox' name='check' value='4' /> 관측일수: <input type="text" name='4'><p>
		<input type='radio' name='r4' value='=' checked/> 일치
		<input type='radio' name='r4' value='>=' /> 이상
		<input type='radio' name='r4' value='<=' /> 이하<p>
		<input type='checkbox' name='check' value='5' /> 최대농도(㎍/㎥/시): <input type="text" name='5'><p>
		<input type='radio' name='r5' value='=' checked/> 일치
		<input type='radio' name='r5' value='>=' /> 이상
		<input type='radio' name='r5' value='<=' /> 이하<p>
		<input type=submit> <input type=reset>
	</form> 
	<a href='data_main.jsp'>[메인 화면]</a>
</div>
</body>
</html>
