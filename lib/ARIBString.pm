package ARIBString;
use strict;
use warnings;
use utf8;
use Encode;

my %symbols = (
  alnum => [
    "！","”","＃","＄","％","＆","’","（","）","＊","＋","，","－","．","／",
    "０", "１", "２", "３", "４", "５", "６", "７", "８", "９", "：", "；", "＜", "＝", "＞", "？",
    "＠", "Ａ", "Ｂ", "Ｃ", "Ｄ", "Ｅ", "Ｆ", "Ｇ", "Ｈ", "Ｉ", "Ｊ", "Ｋ", "Ｌ", "Ｍ", "Ｎ", "Ｏ",
    "Ｐ", "Ｑ", "Ｒ", "Ｓ", "Ｔ", "Ｕ", "Ｖ", "Ｗ", "Ｘ", "Ｙ", "Ｚ", "［", "￥", "］", "＾", "＿",
    "　", "ａ", "ｂ", "ｃ", "ｄ", "ｅ", "ｆ", "ｇ", "ｈ", "ｉ", "ｊ", "ｋ", "ｌ", "ｍ", "ｎ", "ｏ",
    "ｐ", "ｑ", "ｒ", "ｓ", "ｔ", "ｕ", "ｖ", "ｗ", "ｘ", "ｙ", "ｚ", "｛", "｜", "｝", "￣", "　"
  ],
  hiragana => [
    "ぁ", "あ", "ぃ", "い", "ぅ", "う", "ぇ", "え", "ぉ", "お", "か", "が", "き", "ぎ", "く",
    "ぐ", "け", "げ", "こ", "ご", "さ", "ざ", "し", "じ", "す", "ず", "せ", "ぜ", "そ", "ぞ", "た",
    "だ", "ち", "ぢ", "っ", "つ", "づ", "て", "で", "と", "ど", "な", "に", "ぬ", "ね", "の", "は",
    "ば", "ぱ", "ひ", "び", "ぴ", "ふ", "ぶ", "ぷ", "へ", "べ", "ぺ", "ほ", "ぼ", "ぽ", "ま", "み",
    "む", "め", "も", "ゃ", "や", "ゅ", "ゆ", "ょ", "よ", "ら", "り", "る", "れ", "ろ", "ゎ", "わ",
    "ゐ", "ゑ", "を", "ん", "　", "　", "　", "ゝ", "ゞ", "ー", "。", "「", "」", "、", "・", "　"
  ],
  katakana => [
    "ァ", "ア", "ィ", "イ", "ゥ", "ウ", "ェ", "エ", "ォ", "オ", "カ", "ガ", "キ", "ギ", "ク",
    "グ", "ケ", "ゲ", "コ", "ゴ", "サ", "ザ", "シ", "ジ", "ス", "ズ", "セ", "ゼ", "ソ", "ゾ", "タ",
    "ダ", "チ", "ヂ", "ッ", "ツ", "ヅ", "テ", "デ", "ト", "ド", "ナ", "ニ", "ヌ", "ネ", "ノ", "ハ",
    "バ", "パ", "ヒ", "ビ", "ピ", "フ", "ブ", "プ", "ヘ", "ベ", "ペ", "ホ", "ボ", "ポ", "マ", "ミ",
    "ム", "メ", "モ", "ャ", "ヤ", "ュ", "ユ", "ョ", "ヨ", "ラ", "リ", "ル", "レ", "ロ", "ヮ", "ワ",
    "ヰ", "ヱ", "ヲ", "ン", "ヴ", "ヵ", "ヶ", "ヽ", "ヾ", "ー", "。", "「", "」", "、", "・", "　"
  ],
  jisx_0201_katakana => [
    "。", "「", "」", "、", "・", "ヲ", "ァ", "ィ", "ゥ", "ェ", "ォ", "ャ", "ュ", "ョ", "ッ",
    "ー", "ア", "イ", "ウ", "エ", "オ", "カ", "キ", "ク", "ケ", "コ", "サ", "シ", "ス", "セ", "ソ",
    "タ", "チ", "ツ", "テ", "ト", "ナ", "ニ", "ヌ", "ネ", "ノ", "ハ", "ヒ", "フ", "ヘ", "ホ", "マ",
    "ミ", "ム", "メ", "モ", "ヤ", "ユ", "ヨ", "ラ", "リ", "ル", "レ", "ロ", "ワ", "ン", "゛", "゜",
  ],
  # 2-STD-B24v5_3-1p3.pdf P.80 表 7-11 ISO/IEC 10646:2003
  85 => [ # 0x7521
    "\x{3402}", "\x{20158}", "\x{4EFD}", "\x{4EFF}", "\x{4F9A}", "\x{4FC9}", "\x{509C}", "\x{511E}",
    "\x{51BC}", "\x{351F}", "\x{5307}", "\x{5361}", "\x{536C}", "\x{8A79}", "\x{20BB7}", "\x{544D}",
    "\x{5496}", "\x{549C}", "\x{54A9}", "\x{550E}", "\x{554A}", "\x{5672}", "\x{56E4}", "\x{5733}",
    "\x{5734}", "\x{FA10}", "\x{5880}", "\x{59E4}", "\x{5A23}", "\x{5A55}", "\x{5BEC}", "\x{FA11}",
    "\x{37e2}", "\x{5EAC}", "\x{5F34}", "\x{5F45}", "\x{5FB7}", "\x{6017}", "\x{FA6B}", "\x{6130}",
    "\x{6624}", "\x{66C8}", "\x{66D9}", "\x{66FA}", "\x{66FB}", "\x{6852}", "\x{9fc4}", "\x{6911}",
    "\x{693B}", "\x{6A45}", "\x{6A91}", "\x{6ADB}", "\x{233CC}", "\x{233FE}", "\x{235C4}", "\x{6BF1}",
    "\x{6CE0}", "\x{6D2E}", "\x{FA45}", "\x{6DBF}", "\x{6DCA}", "\x{6DF8}", "\x{FA46}", "\x{6F5E}",
    "\x{6FF9}", "\x{7064}", "\x{FA6C}", "\x{242EE}", "\x{7147}", "\x{71C1}", "\x{7200}", "\x{739F}",
    "\x{73A8}", "\x{73C9}", "\x{73D6}", "\x{741B}", "\x{7421}", "\x{FA4A}", "\x{7426}", "\x{742A}",
    "\x{742C}", "\x{7439}", "\x{744B}", "\x{3EDA}", "\x{7575}", "\x{7581}", "\x{7772}", "\x{4093}",
    "\x{78C8}", "\x{78E0}", "\x{7947}", "\x{79AE}", "\x{9FC6}", "\x{4103}"
  ],
  86 => [ # 0x7621
    "\x{9FC5}", "\x{79DA}", "\x{7A1E}", "\x{7B7F}", "\x{7C31}", "\x{4264}", "\x{7D8B}", "\x{7FA1}",
    "\x{8118}", "\x{813A}", "\x{FA6D}", "\x{82AE}", "\x{845B}", "\x{84DC}", "\x{84EC}", "\x{8559}",
    "\x{85CE}", "\x{8755}", "\x{87EC}", "\x{880B}", "\x{88F5}", "\x{89D2}", "\x{8AF6}", "\x{8DCE}",
    "\x{8FBB}", "\x{8FF6}", "\x{90DD}", "\x{9127}", "\x{912D}", "\x{91B2}", "\x{9233}", "\x{9288}",
    "\x{9321}", "\x{9348}", "\x{9592}", "\x{96DE}", "\x{9903}", "\x{9940}", "\x{9AD9}", "\x{9BD6}",
    "\x{9DD7}", "\x{9EB4}", "\x{9EB5}"
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

sub PutKanjiChar { Encode::decode('jis0208-raw', pack("n", shift)) }
sub PutHiraganaChar { $symbols{hiragana}[(shift) - 0x21] }
sub PutKatakanaChar { $symbols{katakana}[(shift) - 0x21] }
sub PutJisKatakanaChar { $symbols{jisx_0201_katakana}[(shift) - 0x21] }
sub PutAlphaNumeric { $symbols{alnum}[(shift) - 0x21] }
sub PutMosaicChar {}
sub PutDRCSChar {}

sub PutSymbolChar {
  my $s = shift;
  my $ku = ($s >> 8) - 0x20;
  $symbols{$ku}[$s - (0x7521 + 0x100 * ($ku - 85))];
}


my %charsize = (
  \&PutKanjiChar => 2,
  \&PutHiraganaChar => 1,
  \&PutKatakanaChar => 1,
  \&PutAlphaNumeric => 1,
  \&PutSymbolChar => 2,
  \&PutMosaicChar => 1,
  \&PutJisKatakanaChar => 1,
  \&PutDRCSChar => 1,
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

my %drcs = (
  "\x40" => \&PutDRCSChar,	# DRCS-0
  "\x41" => \&PutDRCSChar,	# DRCS-1
  "\x42" => \&PutDRCSChar,	# DRCS-2
  "\x43" => \&PutDRCSChar,	# DRCS-3
  "\x44" => \&PutDRCSChar,	# DRCS-4
  "\x45" => \&PutDRCSChar,	# DRCS-5
  "\x46" => \&PutDRCSChar,	# DRCS-6
  "\x47" => \&PutDRCSChar,	# DRCS-7
  "\x48" => \&PutDRCSChar,	# DRCS-8
  "\x49" => \&PutDRCSChar,	# DRCS-9
  "\x4a" => \&PutDRCSChar,	# DRCS-10
  "\x4b" => \&PutDRCSChar,	# DRCS-11
  "\x4c" => \&PutDRCSChar,	# DRCS-12
  "\x4d" => \&PutDRCSChar,	# DRCS-13
  "\x4e" => \&PutDRCSChar,	# DRCS-14
  "\x4f" => \&PutDRCSChar,	# DRCS-15
  "\x70" => \&PutDRCSChar,	# DRCS-Macro
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
    my $s1 = unpack("C", substr($src, $offset, 1));
    if ($s1 == 0x0f) {				# LS0
      $gl = 0;
      ++$offset;
    } elsif ($s1 == 0x0e) {			# LS1
      $gl = 1;
      ++$offset;
    } elsif ($s1 == 0x19) {			# SS2
      $ss = 2;
      ++$offset;
    } elsif ($s1 == 0x1d) {			# SS3
      $ss = 3;
      ++$offset;
    } elsif ($s1 == 0x1b) {			# ESC
      my $s2 = substr($src, $offset + 1, 1);
      if ($s2 eq "\x6e") {			# LS2
        $gl = 2;
        $offset += 2;
      } elsif ($s2 eq "\x6f") {		# LS3
        $gl = 3;
        $offset += 2;
      } elsif ($s2 eq "\x7e") {		# LS1R
        $gr = 1;
        $offset += 2;
      } elsif ($s2 eq "\x7d") {		# LS2R
        $gr = 2;
        $offset += 2;
      } elsif ($s2 eq "\x7c") {		# LS3R
        $gr = 3;
        $offset += 2;
      } elsif ($s2 eq "\x24") {
        my $s3 = substr($src, $offset + 2, 1);
        if ($s3 eq "\x28") {			# DRCS2_G0 \x1b\x24\x28\x20\xXX
          $ops{0} = $drcs{substr($src, $offset + 4, 1)};
          $offset += 5;
        } elsif ($s3 eq "\x29") {
          my $s4 = substr($src, $offset + 3, 1);
          if ($s4 eq "\x20") {			# DRCS2_G1 \x1b\x24\x29\x20\xXX
            $ops{1} = $drcs{substr($src, $offset + 4, 1)};
            $offset += 5;
          } else {				# GSET2_G1 \x1b\x24\x29\xXX
            $ops{1} = $gset{$s4};
            $offset += 4;
          }
        } elsif ($s3 eq "\x2a") {
          my $s4 = substr($src, $offset + 3, 1);
          if ($s4 eq "\x20") {			# DRCS2_G2 \x1b\x24\x2a\x20\xXX
            $ops{2} = $drcs{substr($src, $offset + 4, 1)};
            $offset += 5;
          } else 	{			# GSET2_G2 \x1b\x24\x2a\xXX
            $ops{2} = $gset{$s4};
            $offset += 4;
          }
        } elsif ($s3 eq "\x2b") {
          my $s4 = substr($src, $offset + 3, 1);
          if ($s4 eq "\x20") {			# DRCS2_G3 \x1b\x24\x2b\x20\xXX
            $ops{3} = $drcs{substr($src, $offset + 4, 1)};
            $offset += 5;
          } else {				# GSET2_G3 \x1b\x24\x2b\xXX
            $ops{3} = $gset{$s4};
            $offset += 4;
          }
        } else {				# GSET2_G0 \x1b\x24\xXX
          $ops{0} = $gset{$s3};
          $offset += 3;
        }
      } elsif ($s2 eq "\x28") {
        my $s3 = substr($src, $offset + 2, 1);
        if ($s3 eq "\x20") {			# DRCS1_G0 \x1b\x28\x20\xXX
          $ops{0} = $drcs{substr($src, $offset + 3, 1)};
          $offset += 4;
        } else {				# GSET1_G0 \x1b\x28\xXX
          $ops{0} = $gset{$s3};
          $offset += 3;
        }
      } elsif ($s2 eq "\x29") {
        my $s3 = substr($src, $offset + 2, 1);
        if ($s3 eq "\x20") {			# DRCS1_G1 \x1b\x29\x20\xXX
          $ops{1} = $drcs{substr($src, $offset + 3, 1)};
          $offset += 4;
        } else {				# GSET1_G1 \x1b\x29\xXX
          $ops{1} = $gset{$s3};
          $offset += 3;
        }
      } elsif ($s2 eq "\x2a") {
        my $s3 = substr($src, $offset + 2, 1);
        if ($s3 eq "\x20") {			# DRCS1_G2 \x1b\x2a\x20\xXX
          $ops{2} = $drcs{substr($src, $offset + 3, 1)};
          $offset += 4;
        } else {				# GSET1_G2 \x1b\x2a\xXX
          $ops{2} = $gset{$s3};
          $offset += 3;
        }
      } elsif ($s2 eq "\x2b") {
        my $s3 = substr($src, $offset + 2, 1);
        if ($s3 eq "\x20") {			# DRCS1_G3 \x1b\x2b\x20\xXX
          $ops{3} = $drcs{substr($src, $offset + 3, 1)};
          $offset += 4;
        } else {				# GSET1_G3 \x1b\x2b\xXX
          $ops{3} = $gset{$s3};
          $offset += 3;
        }
      } else {
        map { printf STDERR "%02x",$_ } unpack("C*", substr($src, $offset, 5)); print STDERR "\n";
        die "break escape sequence\n";
        $offset++;
      }
    } elsif ($s1 == 0x89) {			# MSZ
      ++$offset;
    } elsif ($s1 == 0x8a) {			# NSZ
      ++$offset;
    } elsif ($s1 == 0x20 or $s1 == 0xa0) {	# SPC
      $dest .= " ";
      ++$offset;
    } elsif ($s1 >= 0x21 && $s1 <= 0x7e) {	# GL
      my $op = $ss ? $ops{$ss} : $ops{$gl};
      my $size = $charsize{$op};
      my $data = unpack($size == 1 ? "C" : "n", substr($src, $offset, $size));
      $ss = 0;
      if (length($src) >= $offset + $size) {
        $dest .= &$op($data & 0x7f7f) || '';
      }
      $offset += $size;
    } elsif ($s1 >= 0xa1 && $s1 <= 0xfe) {	# GR
      my $op = $ops{$gr};
      my $size = $charsize{$op};
      my $data = unpack($size == 1 ? "C" : "n", substr($src, $offset, $size));
      if (length($src) >= $offset + $size) {
        $dest .= &$op($data & 0x7f7f) || '';
      }
      $offset += $size;
    } else {
      $offset++;
    }
  }
  #print Encode::encode('utf-8', $dest)."\n";
  return Encode::encode('utf-8', $dest);
}

1;
