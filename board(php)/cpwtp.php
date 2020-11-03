<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<html> <body>
<h2>댓글 아이디/비밀번호 입력</h2>
<?php 
	$cidx = trim(strip_tags(addslashes($_GET["cidx"])));
	$case = trim(strip_tags(addslashes($_GET["case"])));
	$idx = trim(strip_tags(addslashes($_GET["idx"])));
?>
<form action="cpwtp.php?idx=<?php echo $idx; ?>&cidx=<?php echo $cidx; ?>&case=<?php echo $case; ?>" method=post>
	아이디: <input type="text" name="name"><br>
	비밀번호: <input type="password" name="pw"><br>
 	<input type=submit> <input type=reset>
</form>
<?php
	$link = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");
	$name = trim(strip_tags(addslashes($_POST["name"])));
	$pw = trim(strip_tags(addslashes($_POST["pw"])));	
	$q = "select name, AES_DECRYPT(UNHEX(pw), 'test') as pw from comm where idx = '$cidx'";
	$res = mysqli_fetch_assoc($link->query($q));

	if($case == 0) {		
		if ($name == $res['name'] && $pw == $res['pw']) {
			$q = "delete from comm where idx='$cidx'";
			$st = $link->prepare($q);
			$st->execute();
			echo "<script>alert('삭제를 완료 하였습니다.'); location.href='read.php?idx=$idx';</script>";
		}else {
			echo "<script> alert('알맞은 아이디와 비밀번호를 입력해주세요.'); </script>";
		}	

	} else if($case == 1) {
		if ($name == $res['name'] && $pw == $res['pw']) {
			echo "<script>location.href='cedit.php?cidx=$cidx'; </script>";
		}else {
			echo "<script> alert('알맞은 아이디와 비밀번호를 입력해주세요.'); </script>";
		}
	} 
?>

<p>
<a href="read.php?idx=<?php echo $idx; ?>.php">[돌아가기]</a><br>
<a href="board.php">[글 목록]</a>

</body>
</html>
