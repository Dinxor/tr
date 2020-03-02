$size0 = FileGetSize ( @ScriptDir & "\tr_settings.ini" )
If @error Then
    MsgBox(16, "Error", "Ini file not found")
    Exit - 1
EndIf

$Clear = IniReadSection("tr_settings.ini", "Clear")
$Change = IniReadSection("tr_settings.ini", "Change")
$Target = IniReadSection("tr_settings.ini", "Target")
$Short = IniRead("tr_settings.ini", "Short", "Cut", 0 )
$prev = ""

While 1
	$curr = ClipGet()
	If $curr <> $prev Then
		$str = $curr
		For $i = 1 to $Clear[0][0]
			If StringInStr ( $str, $Clear[$i][1] ) > 0 Then $str = StringReplace ( $str, $Clear[$i][1], "")
		Next
		For $i = 1 to $Change[0][0]
			If StringInStr ( $str, $Change[$i][0] ) > 0 Then
				$n = $Change[$i][1]+1
				If $Target[0][0] >= $n Then $str = StringReplace ( $str, $Change[$i][0], $Target[$n][1])
			EndIf
		Next
		If $str <> $curr Then
			If $Short > 0 Then
				$endpos = StringInStr ( $str, "/", 0, 4)
				If $endpos > 0 and StringInStr ( $str, "folder") = 0 Then $str = StringLeft( $str, $endpos-1 ) & ".html"
			EndIf
			ClipPut($str)
		EndIf
		$prev = $curr
	EndIf
	Sleep(100)
Wend