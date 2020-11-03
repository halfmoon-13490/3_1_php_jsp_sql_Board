<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<html> <body>
<h2>게시물 아이디/비밀번호 입력</h2>
<?php
	$idx = trim(strip_tags(addslashes($_GET["idx"])));
	$case = trim(strip_tags(addslashes($_GET["case"])));
?>

<form action="pwtp.php?idx=<?php echo $idx; ?>&case=<?php echo $case; ?>" method=post>
	아이디: <input type="text" name="name"><p>
 	비밀번호: <input type="password" name="pw"><p>
 <input type=submit> <input type=reset>
 </form>
<?php
	$link = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");
	$name = trim(strip_tags(addslashes($_POST["name"])));
	$pw = trim(strip_tags(addslashes($_POST["pw"])));
	
	$q = "select name, AES_DECRYPT(UNHEX(pw), 'test') as pw from pan where idx = '$idx'";
	$res = mysqli_fetch_assoc($link->query($q));
	
	if($case == 0) {
		if($name == $res['name'] && $pw == $res['pw']) {
			$q = "delete from pan where idx='$idx'";
			$st = $link->prepare($q);
			$st->execute();
			// delete comments			
			$q2 = "delete from comm where num = '$idx'";
			$link->query($q2);
		
			echo "<script>alert('삭제를 완료 하였습니다.'); location.href='board.php';</script>";
		}else {
			echo "<script> alert('알맞은 아이디와 비밀번호를 입력해주세요.'); </script>";
		}
	} else if($case == 1) {	
		if($name == $res['name'] && $pw == $res['pw']) {
			echo "<script>location.href='edit.php?idx=$idx'; </script>";
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
