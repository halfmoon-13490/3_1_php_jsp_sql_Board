<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<html> 
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
<body>
<div id= 'dv'>
<?php
	$str = trim(strip_tags(addslashes($_GET["select"])));
	$sch = trim(strip_tags(addslashes($_GET["search"])));
	if($str == 'title')	{
		$txt = '제목';
	} else if($str ==  'name') {
		$txt = '글쓴이';
	} else if($str ==  'cntnt') {
		$txt = '내용';
	} else if($str ==  'idx') {
		$txt = '번호';
	}
?>
<h2><?php echo $txt."에서 '".$sch."' 검색 결과" ?></h2>
   
<table>
<?php
	$link = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");
	$link2 = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");
	
  echo "<tr bgcolor=lightblue>";
  echo "<th>번호</th><th style='width: 600px'>제목</th><th style='width: 200px'>글쓴이</th><th style='width: 200px'>날짜</th><th>조회수</th>";
  echo "</tr><br>";
  

  $q = "SELECT * FROM pan where $str like '%$sch%' ORDER BY idx DESC";
  $st = $link->prepare($q);
  $st->execute();
  $st->bind_result($tidx, $tname, $tpw, $tcntnt, $tdate, $tip, $ttitle, $tcnt);

  
  while($st->fetch()) { 
		$q2 = "select count(*) as count from comm where num='$tidx'";
		$res = mysqli_fetch_assoc($link2->query($q2));

		echo "<tr>";
		echo "<td>".$tidx."</td>";
		echo "<td><a href='read.php?idx=$tidx'>".$ttitle."</a> <span style='color:red; font-size:0.8em;'>[".$res['count']."]</span></td>";
		echo "<td>".$tname."</td><td>".$tdate."</td><td>".$tcnt."</td>";
		echo "</tr>";
    
    }
	

?>
</table>
<p><a href="board.php">홈으로</a>

<form action="search.php" method=get>
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


