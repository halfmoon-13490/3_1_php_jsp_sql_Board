<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<html> <body>
<?php
	$link2 = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");
	$num = trim(strip_tags(addslashes($_GET['idx'])));
	$q5 = "select title from pan where idx = '$num'";
	$res = mysqli_fetch_assoc($link2->query($q5));
?>
<h2><?php echo "□".$res['title']."□"; ?></h2>

<?php
	$link = new mysqli("localhost", "kimhyeg1021", "KSkimhyeg1021M", "kimhyeg1021");
	
	$q = "select count from pan where idx = '$num'";

	$res = mysqli_fetch_assoc($link->query($q));
	$hit = $res['count'] + 1;


	$q2 = "update pan set count = '$hit' where idx = '$num'";
	$link->query($q2);

	$q3 = "select * from pan where idx = '$num'";
	$st = $link->prepare($q3);
	$st->execute();
	$st->bind_result($tidx, $tname, $tpw, $tcntnt, $tdate, $tip, $ttitle, $tcnt);
	while($st->fetch()) { 
		echo "글쓴이: ".$tname." | 날짜: ".$tdate." | 조회수: ".$hit;
		echo "<br>ip : ".$tip."<br>";
		echo "<h3>".$tcntnt."</h3><p>";

		
    
  	 }
	
	$q4 = "select name, cntnt, date, idx from comm where num = '$num' order by idx desc";
	$result = $link->query($q4);
	echo "<p><b>[댓글]</b> <br>";
	while($rr = mysqli_fetch_assoc($result)) {
		echo "<b>".$rr['name']."</b> : ".$rr['cntnt']."<br><span style='font-size:0.8em;'>[".$rr['date']."]</span>";
	?>
		<a href="cpwtp.php?idx=<?php echo $num; ?>&case=1&cidx=<?php echo $rr['idx']; ?>" style='font-size:0.8em;'>[수정]</a>
		<a href="cpwtp.php?idx=<?php echo $num; ?>&case=0&cidx=<?php echo $rr['idx']; ?>" style='font-size:0.8em;'>[삭제]</a><p>
	
	<?php } 
?>

<p>

<a href="board.php">[목록으로]</a><br>
<a href="pwtp.php?idx=<?php echo $num; ?>&case=1">[수정]</a><br>
<a href="pwtp.php?idx=<?php echo $num; ?>&case=0">[삭제]</a><p>
<b>[댓글 입력]</b>
<form action="comment.php?idx=<?php echo $num; ?>" method=post>
			<input type="text" name="comm_name" size="15" placeholder="아이디">
			<input type="password" name="comm_pw" size="15" placeholder="비밀번호">
			<div style="margin-top:10px;">
				<textarea name="comm_cntnt" cols="38" rows="5"></textarea>
				<input type="submit">
			</div>
		</form>
</body>
</html>
