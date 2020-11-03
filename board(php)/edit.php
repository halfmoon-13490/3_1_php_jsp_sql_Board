<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<html> <body>
<h2>게시물 수정</h2>
<?php
	$idx = trim(strip_tags(addslashes($_GET["idx"])));
?>
<form action="edit.php?idx=<?php echo $idx; ?>" method=post>
	제목: <input type="text" name="title"><br>
	내용: <br><textarea name="cntnt" cols="50" rows="20"></textarea><br>
	<input type=submit> <input type=reset>
</form>
<p>
<?php
	$link = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");

 	date_default_timezone_set('Asia/Seoul');
  	$date = Date("Y/n/j H:i:s");

 	$ip = $_SERVER["REMOTE_ADDR"];
  	echo "IP: $ip<br>날짜: $date";

   	$cntnt = trim(strip_tags(addslashes($_POST["cntnt"])));
	$title = trim(strip_tags(addslashes($_POST["title"])));
	

	if($cntnt != '' && $title != '') {
		$q = "update pan set cntnt = '$cntnt', title = '$title', ip = '$ip', date = '$date' where idx='$idx'";
		$st = $link->prepare($q);
		$st->execute();
		echo "<script> alert('수정에 성공했습니다.'); location.href='read?idx=$idx.php';</script>";
	} else {
		echo "<script> alert('제목, 내용을 입력해주세요.');</script>";
	}

?>
<p><a href="board.php">[목록으로]</a> 
	<a href="read.php?idx=<?php echo $idx; ?>">[게시글로]</a> 
</body>
</html>
