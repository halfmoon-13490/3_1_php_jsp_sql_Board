<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<html> <body>
<h2>댓글 수정</h2>
<?php	
	$cidx = trim(strip_tags(addslashes($_GET["cidx"])));
?>
<form action="cedit.php?cidx=<?php echo $cidx; ?>" method=post>
	내용 입력: <br><textarea name="comm_cntnt" cols="38" rows="5"></textarea><p>
				<input type="submit"> <input type=reset>
</form>
<?php
	$link = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");
	

  	date_default_timezone_set('Asia/Seoul');
  	$date = Date("Y/n/j H:i:s");
  	$ip = $_SERVER["REMOTE_ADDR"];
	echo "IP: $ip<br>날짜: $date";

  	$cntnt = trim(strip_tags(addslashes($_POST["comm_cntnt"])));

	$q2 = "select * from comm where idx = '$cidx'";
	$res2 = mysqli_fetch_assoc($link->query($q2));
	$idx = $res2['num'];
	
	if($cntnt != '') {
		$q = "update comm set cntnt = '$cntnt', date = '$date' where idx='$cidx'";
		$st = $link->prepare($q);
		$st->execute();
		echo "<script> alert('수정에 성공했습니다.'); location.href='read.php?idx=$idx';</script>";
	} else {
		echo "<script> alert('내용을 입력해주세요.'); </script>";
	}

?>
<p><a href="board.php">[목록으로]</a> 
	<a href="read.php?idx=<?php echo $idx; ?>">[게시글로]</a> 
</body>
</html>
