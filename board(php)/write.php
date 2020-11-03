<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<body>
<h2>게시물 작성</h2>
<form action="write.php" method=post>
	제목: <input type="text" name="title"><br>
	아이디: <input type="text" name="name"><br>
	비밀번호: <input type="password" name="pw"><br>
 	내용: <br><textarea name="cntnt" cols="50" rows="20"></textarea><br>

<?php
  date_default_timezone_set('Asia/Seoul');
  $d = Date("Y/n/j H:i:s");

  $ip = $_SERVER["REMOTE_ADDR"];
  echo "IP: $ip<br>날짜: $d<p>";
?>
 <input type=hidden name="date" value="<?php echo $d ?>"><br>
 <input type=hidden name="ip" value="<?php echo $ip ?>">
 <input type=submit> <input type=reset>
</form>
<?php
	 $link = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");
	$name = trim(strip_tags(addslashes($_POST["name"])));
    $cntnt = trim(strip_tags(addslashes($_POST["cntnt"])));
    $date = trim(strip_tags(addslashes($_POST["date"])));
    $ip = trim(strip_tags(addslashes($_POST["ip"])));
    $pw = trim(strip_tags(addslashes($_POST["pw"])));
	
	$title = trim(strip_tags(addslashes($_POST["title"])));
	if($name != '' && $cntnt != '' && $pw != '' && $title != '') {
		$reset = "alter table pan auto_increment =1";
		$link->query($reset);
		$q = "insert into pan(name, pw, cntnt, date, ip, title, count) VALUES('$name', HEX(AES_ENCRYPT('$pw', 'test')), '$cntnt', '$date', '$ip', '$title', 0)";
		$st = $link->prepare($q);
		$st->execute();
		echo "<script> alert('글쓰기에 성공했습니다.'); location.href='board.php';</script>";
	} else {
		echo "<script> alert('아이디, 제목, 내용, 비밀번호를 입력해주세요.');</script>";
	}

?>
<p><a href="board.php">[돌아가기]</a>

</body>
</html>
