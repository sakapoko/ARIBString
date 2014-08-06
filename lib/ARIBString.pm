package ARIBString;
use strict;
use warnings;
use utf8;
use Encode;

my $hiragana =
  "　ぁあぃいぅうぇえぉおかがきぎく".
  "ぐけげこごさざしじすずせぜそぞた".
  "だちぢっつづてでとどなにぬねのは".
  "ばぱひびぴふぶぷへべぺほぼぽまみ".
  "むめもゃやゅゆょよらりるれろゎわ".
  "ゐゑをん　　　ゝゞー。「」、・　";

my $katakana =
  "　ァアィイゥウェエォオカガキギク".
  "グケゲコゴサザシジスズセゼソゾタ".
  "ダチヂッツヅテデトドナニヌネノハ".
  "バパヒビピフブプヘベペホボポマミ".
  "ムメモャヤュユョヨラリルレロヮワ".
  "ヰヱヲンヴヵヶヽヾー。「」、・　";

my $jisx_0201_katakana =
  "　。「」、・ヲァィゥェォャュョッ".
  "ーアイウエオカキクケコサシスセソ".
  "タチツテトナニヌネノハヒフヘホマ".
  "ミムメモヤユヨラリルレロワン゛゜".
  "　　　　　　　　　　　　　　　　".
  "　　　　　　　　　　　　　　　　";

# 2-STD-B24v5_3-1p3.pdf P.80 表 7-11 ISO/IEC 10646:2003
my %symbol = (
  85 => [ # 0x7521
    0x3402, 0x20158, 0x4EFD, 0x4EFF, 0x4F9A, 0x4FC9, 0x509C, 0x511E, 0x51BC, 0x351F, 0x5307, 0x5361,
    0x536C, 0x8A79, 0x20BB7, 0x544D, 0x5496, 0x549C, 0x54A9, 0x550E, 0x554A, 0x5672, 0x56E4, 0x5733,
    0x5734, 0xFA10, 0x5880, 0x59E4, 0x5A23, 0x5A55, 0x5BEC, 0xFA11, 0x37e2, 0x5EAC, 0x5F34, 0x5F45,
    0x5FB7, 0x6017, 0xFA6B, 0x6130, 0x6624, 0x66C8, 0x66D9, 0x66FA, 0x66FB, 0x6852, 0x9fc4, 0x6911,
    0x693B, 0x6A45, 0x6A91, 0x6ADB, 0x233CC, 0x233FE, 0x235C4, 0x6BF1, 0x6CE0, 0x6D2E, 0xFA45, 0x6DBF,
    0x6DCA, 0x6DF8, 0xFA46, 0x6F5E, 0x6FF9, 0x7064, 0xFA6C, 0x242EE, 0x7147, 0x71C1, 0x7200, 0x739F,
    0x73A8, 0x73C9, 0x73D6, 0x741B, 0x7421, 0xFA4A, 0x7426, 0x742A, 0x742C, 0x7439, 0x744B, 0x3EDA,
    0x7575, 0x7581, 0x7772, 0x4093, 0x78C8, 0x78E0, 0x7947, 0x79AE, 0x9FC6, 0x4103
  ],
  86 => [ # 0x7621
    0x9FC5, 0x79DA, 0x7A1E, 0x7B7F, 0x7C31, 0x4264, 0x7D8B, 0x7FA1, 0x8118, 0x813A, 0xFA6D, 0x82AE,
    0x845B, 0x84DC, 0x84EC, 0x8559, 0x85CE, 0x8755, 0x87EC, 0x880B, 0x88F5, 0x89D2, 0x8AF6, 0x8DCE,
    0x8FBB, 0x8FF6, 0x90DD, 0x9127, 0x912D, 0x91B2, 0x9233, 0x9288, 0x9321, 0x9348, 0x9592, 0x96DE,
    0x9903, 0x9940, 0x9AD9, 0x9BD6, 0x9DD7, 0x9EB4, 0x9EB5,
  ],
  90 => [
    '', '', '', '', '', '', '', '',
    '', '', '', '', '', '', '', '',
    '', '', '', '', '', '', '', '',
    '', '', '', '', '', '', '', '',
    '', '', '', '', '', '', '', '',
    '', '', '', '', '', '', '',
    '【HV】', '【SD】', '【Ｐ】', '【Ｗ】', '【MV】', '【手】', '【字】', '【双】',	# 0x7a50-0x7a57
    '【デ】', '【Ｓ】', '【二】', '【多】', '【解】', '【SS】', '【Ｂ】', '【Ｎ】',	# 0x7a58-0x7a5f
    '■',     '●',     '【天】', '【交】', '【映】', '【無】', '【料】', '【鍵】',	# 0x7a60-0x7a67
    '【前】', '【後】', '【再】', '【新】', '【初】', '【終】', '【生】', '【販】',	# 0x7a68-0x7a6f
    '【声】', '【吹】', '【PPV】','【秘】', '【他】', #0x7a70-0x7a74
  ],
  92 => [
    "→", "←", "↑", "↓", "○", "●", "年", "月", "日", "円",
    "㎡", "㎥", "㎝", "㎠", "㎤", "0.", "1.", "2.", "3.", "4.",
    "5.", "6.", "7.", "8.", "9.", "氏", "副", "元", "故", "前",
    "新", "0,", "1,", "2,", "3,", "4,", "5,", "6,", "7,", "8,",
    "9,", "[社]", "[財]", "[有]", "[株]", "[代]", "(問)", "▶", "◀", "〖",
    "〗", "⟐", "^2", "^3", "(CD)", "(vn)", "(ob)", "(cb)", "(ce", "mb)",
    "(hp)", "(br)", "(p)", "(s)", "(ms)", "(t)", "(bs)", "(b)", "(tb)", "(tp)",
    "(ds)", "(ag)", "(eg)", "(vo)", "(fl)", "(ke", "y)", "(sa", "x)", "(sy",
    "n)", "(or", "g)", "(pe", "r)", "(R)", "(C)", "(箏)", "DJ", "[演]",
    "FAX",
  ],
  93 => [
    "㈪", "㈫", "㈬", "㈭", "㈮", "㈯", "㈰", "㈷",               #// 0x7D21 - 0x7D28      93/01 - 93/08
    "㍾", "㍽", "㍼", "㍻", "№", "℡", "〶", "○",               #// 0x7D29 - 0x7D30      93/09 - 93/16
    "〔本〕", "〔三〕", "〔二〕", "〔安〕", "〔点〕", "〔打〕", "〔盗〕", "〔勝〕",           #// 0x7D31 - 0x7D38      93/17 - 93/24
    "〔敗〕", "〔Ｓ〕", "[投]", "[捕]", "[一]", "[二]", "[三]", "[遊]",           #// 0x7D39 - 0x7D40      93/25 - 93/32
    "[左]", "[中]", "[右]", "[指]", "[走]", "[打]", "㍑", "㎏",               #// 0x7D41 - 0x7D48      93/33 - 93/40
    "㎐", "ha", "㎞", "㎢", "㍱", "・", "・", "1/2",		#// 0x7D49 - 0x7D50      93/41 - 93/48
    "0/3", "1/3", "2/3", "1/4", "3/4", "1/5", "2/5", "3/5",              #// 0x7D51 - 0x7D58      93/49 - 93/56
    "4/5", "1/6", "5/6", "1/7", "1/8", "1/9", "1/10", "☀",                #// 0x7D59 - 0x7D60      93/57 - 93/64
    "☁",  "☂", "☃", "☖", "☗", "▽", "▼", "♦",                #// 0x7D61 - 0x7D68      93/65 - 93/72
    "♥", "♣", "♠", "⌺", "⦿", "‼", "⁉", "(曇/晴)",          #// 0x7D69 - 0x7D70      93/73 - 93/80
    "☔", "(雨)", "(雪)", "(大雪)", "(雷)", "(雷雨)", "　", "・",               #// 0x7D71 - 0x7D78      93/81 - 93/88
    "・", "♬", "☎"                                            #// 0x7D79 - 0x7D7B      93/89
  ],
  94 => [
      "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ",     #           // 0x7E21 - 0x7E28      94/01 - 94/08
      "Ⅸ", "Ⅹ", "Ⅺ", "Ⅻ", "⑰", "⑱", "⑲", "⑳",    #            // 0x7E29 - 0x7E30      94/09 - 94/16
      "⑴", "⑵", "⑶", "⑷", "⑸", "⑹",  "⑺", "⑻",      #          // 0x7E31 - 0x7E38      94/17 - 94/24
      "⑼", "⑽", "⑾", "⑿", "㉑", "㉒", "㉓", "㉔",        #       // 0x7E39 - 0x7E40      94/25 - 94/32
      "(A)", "(B)", "(C)", "(D)", "(E)", "(F)", "(G)", "(H)",  #            // 0x7E41 - 0x7E48      94/33 - 94/40
      "(I)", "(J)", "(K)", "(L)", "(M)", "(N)", "(O)", "(P)", #             // 0x7E49 - 0x7E50      94/41 - 94/48
      "(Q)", "(R)", "(S)", "(T)", "(U)", "(V)", "(W)", "(X)", #             // 0x7E51 - 0x7E58      94/49 - 94/56
      "(Y)", "(Z)", "㉕", "㉖", "㉗", "㉘", "㉙", "㉚",  #             // 0x7E59 - 0x7E60      94/57 - 94/64
      "①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", #               // 0x7E61 - 0x7E68      94/65 - 94/72
      "⑨", "⑩", "⑪", "⑫", "⑬", "⑭", "⑮", "⑯", #               // 0x7E69 - 0x7E70      94/73 - 94/80
      "❶", "❷", "❸", "❹", "❺", "❻", "❼", "❽",  #              // 0x7E71 - 0x7E78      94/81 - 94/88
      "❾", "❿", "⓫", "⓬", "㉛"                     #           // 0x7E79 - 0x7E7D      94/89 - 94/93

  ],
);

my %charsize = (
  \&PutKanjiChar => 2,
  \&PutHiraganaChar => 1,
  \&PutKatakanaChar => 1,
  \&PutAlphaNumeric => 1,
  \&PutSymbolChar => 2,
  \&PutMosaicChar => 1,
  \&PutJisKatakanaChar => 1,
);

my %gset = (
  "\x42" => \&PutKanjiChar,	# 漢字系集合
  "\x4a" => \&PutAlphaNumeric,	# 英数集合
  "\x30" => \&PutHiraganaChar,	# 平仮名集合
  "\x31" => \&PutKatakanaChar,	# 片仮名集合
  "\x32" => \&PutMosaicChar,	# モザイク集合A
  "\x33" => \&PutMosaicChar,	# モザイク集合B
  "\x34" => \&PutMosaicChar,	# モザイク集合C
  "\x35" => \&PutMosaicChar,	# モザイク集合D
  "\x36" => \&PutAlphaNumeric,	# Proportional AlphaNumeric
  "\x37" => \&PutHiraganaChar,	# Proportional Hiragana
  "\x38" => \&PutKatakanaChar,	# Proportional Katakana
  "\x39" => \&PutKanjiChar,	# JIS互換漢字1面集合 (JISX0213:2004 1面)
  "\x3a" => \&PutKanjiChar,	# JIS互換漢字2面集合 (JISX0213:2004 2面)
  "\x3b" => \&PutSymbolChar,	# 追加記号集合（ARIB外字）
  "\x49" => \&PutJisKatakanaChar,
);

sub utf8 {
  my $src = shift;
  my $dest = '';
  my $offset = 0;
  my $gl = 0;
  my $gr = 2;
  my $ss = 0;
  my %ops = (
    0 => \&PutKanjiChar,
    1 => \&PutAlphaNumeric,
    2 => \&PutHiraganaChar,
    3 => \&PutKatakanaChar,
  );
  #map { printf "%02x",$_ } unpack("C*", $src); print "\n";

  while (length($src) > $offset) {
    my $s1 = substr($src, $offset, 5);

    if ($s1 =~ /^\x0f/) {			# LS0
      $gl = 0;
      ++$offset;
    } elsif ($s1 =~ /^\x0e/) {			# LS1
      $gl = 1;
      ++$offset;
    } elsif ($s1 =~ /^\x19/) {			# SS2
      $ss = 2;
      ++$offset;
    } elsif ($s1 =~ /^\x1d/) {			# SS3
      $ss = 3;
      ++$offset;
    } elsif ($s1 =~ /^\x1b\x6e/) {		# LS2
      $gl = 2;
      # LockingShiftGL(2)
      $offset += 2;
    } elsif ($s1 =~ /^\x1b\x6f/) {		# LS3
      $gl = 3;
      $offset += 2;
    } elsif ($s1 =~ /^\x1b\x7e/) {		# LS1R
      $gr = 1;
      $offset += 2;
    } elsif ($s1 =~ /^\x1b\x7d/) {		# LS2R
      $gr = 2;
      $offset += 2;
    } elsif ($s1 =~ /^\x1b\x7c/) {		# LS3R
      $gr = 3;
      $offset += 2;
    } elsif ($s1 =~ /^\x1b\x24\x28\x20(.)/) {	# DRCS2_G0
      $offset += 5;
    } elsif ($s1 =~ /^\x1b\x24\x29\x20(.)/) {	# DRCS2_G1
      $offset += 5;
    } elsif ($s1 =~ /^\x1b\x24\x2a\x20(.)/) {	# DRCS2_G2
      $offset += 5;
    } elsif ($s1 =~ /^\x1b\x24\x2b\x20(.)/) {	# DRCS2_G3
      $offset += 5;
    } elsif ($s1 =~ /^\x1b\x24\x29(.)/) {	# GSET2_G1
      $ops{1} = $gset{$1};
      $offset += 4;
    } elsif ($s1 =~ /^\x1b\x24\x2a(.)/) {	# GSET2_G2
      $ops{2} = $gset{$1};
      $offset += 4;
    } elsif ($s1 =~ /^\x1b\x24\x2b(.)/) {	# GSET2_G3
      $ops{3} = $gset{$1};
      $offset += 4;
    } elsif ($s1 =~ /^\x1b\x24(.)/) {		# GSET2_G0
      $ops{0} = $gset{$1};
      $offset += 3;
    } elsif ($s1 =~ /^\x1b\x28\x20(.)/) {	# DRCS1_G0
      $offset += 4;
    } elsif ($s1 =~ /^\x1b\x29\x20(.)/) {	# DRCS1_G1
      $offset += 4;
    } elsif ($s1 =~ /^\x1b\x2a\x20(.)/) {	# DRCS1_G2
      $offset += 4;
    } elsif ($s1 =~ /^\x1b\x2b\x20(.)/) {	# DRCS1_G3
      $offset += 4;
    } elsif ($s1 =~ /^\x1b\x28(.)/) {		# GSET_G0
      $ops{0} = $gset{$1};
      $offset += 3;
    } elsif ($s1 =~ /^\x1b\x29(.)/) {		# GSET_G1
      $ops{1} = $gset{$1};
      $offset += 3;
    } elsif ($s1 =~ /^\x1b\x2a(.)/) {		# GSET_G2
      $ops{2} = $gset{$1};
      $offset += 3;
    } elsif ($s1 =~ /^\x1b\x2b(.)/) {		# GSET_G3
      $ops{3} = $gset{$1};
      $offset += 3;
    } elsif ($s1 =~ /^\x1b/) {			# ESC
      ++$offset;
    } elsif ($s1 =~ /^\x89/) {			# MSZ
      ++$offset;
    } elsif ($s1 =~ /^\x8a/) {			# NSZ
      ++$offset;
    } elsif ($s1 =~ /^\x20/) {			# SPC
      ++$offset;
    } elsif (unpack("C", $s1) >= 0x21 && unpack("C", $s1) <= 0x7e) { # GL
      my $op = $ss ? $ops{$ss} : $ops{$gl};
      my $size = $charsize{$op};
      $ss = 0;
      if (length($s1) >= $size) {
        $dest .= &$op(substr($s1, 0, $size)) || '';
      }
      $offset += $size;
    } elsif ($s1 =~ /^\xa0/) {	# SPC
      $dest .= " ";
      ++$offset;
    } elsif (unpack("C", $s1) >= 0xa1 && unpack("C", $s1) <= 0xfe) { # GR
      my $size = $charsize{$ops{$gr}};
      if (length($s1) >= $size) {
        $dest .= $ops{$gr}(substr($s1, 0, $size)) || '';
      }
      $offset += $size;
    } else {
      $offset++;
    }
  }
  return Encode::encode('utf-8', $dest);
}

sub PutKanjiChar {
  my $s = shift;
  return Encode::decode('jis0208-raw', $s);
}

sub PutHiraganaChar {
  my $s = shift;
  return substr($hiragana, (unpack("C", $s) & 0x7f) - 0x20, 1);
}

sub PutKatakanaChar {
  my $s = shift;
  return substr($katakana, (unpack("C", $s) & 0x7f) - 0x20, 1);
}

sub PutJisKatakanaChar {
  my $s = shift;
  return substr($jisx_0201_katakana, (unpack("C", $s) & 0x7f) - 0x20, 1);
}

sub PutAlphaNumeric {
  my $s = shift;
  return chr(unpack("C", $s) & 0x7f);
}

sub PutSymbolChar {
  my $s = shift;
  my $n = unpack("n", $s);
  my $ku = ($n >> 8) - 0x20;
  if ($ku == 85) {
    return chr($symbol{85}[$n - 0x7521]);
  } elsif ($ku == 86) {
    return chr($symbol{86}[$n - 0x7621]);
  } elsif ($ku == 90) {
    return $symbol{90}[$n - 0x7a21];
  } elsif ($ku == 92) {
    return $symbol{92}[$n - 0x7c21];
  } elsif ($ku == 93) {
    return $symbol{93}[$n - 0x7d21];
  } elsif ($ku == 94) {
    return $symbol{"94_alt"}[$n - 0x7e21];
  }
  return '';
}

sub PutMosaicChar {
  return '';
}

1;
