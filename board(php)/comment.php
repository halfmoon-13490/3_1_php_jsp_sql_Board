<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<html>
<body> 
<?php
	date_default_timezone_set('Asia/Seoul');
	$date = Date("Y/n/j H:i:s");

	$link = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");

	$idx = trim(strip_tags(addslashes($_GET["idx"])));
	$name = trim(strip_tags(addslashes($_POST["comm_name"])));
	$cntnt = trim(strip_tags(addslashes($_POST["comm_cntnt"])));
	$pw = trim(strip_tags(addslashes($_POST["comm_pw"])));
	
	if($name != '' && $cntnt != '' && $pw != '') {
		$q = "insert into comm(num, name, pw, cntnt, date) VALUES('$idx', '$name', HEX(AES_ENCRYPT('$pw', 'test')), '$cntnt', '$date')";
		$st = $link->prepare($q);
		$st->execute();
		echo "<script> alert('댓글작성에 성공했습니다.'); location.href='read.php?idx=$idx';</script>";
	} else {
		echo "<script> alert('댓글과 아이디,  비밀번호를 입력해주세요.'); location.href='read.php?idx=$idx';</script>";
	}

?>

</body>
</html>
