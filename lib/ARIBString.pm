package ARIBString;
use strict;
use warnings;
use utf8;
use Encode;

our $VERSION = '0.91';

use overload
  q("")    => sub {$_[0]->as_string},
  q(.=)    => sub {$_[0]->append($_[1])},
  fallback => 1;

sub new {
  my $class = shift;
  my $data  = $_[0];
  my $self  = bless {}, $class;
  my $ref   = ref($data) ? $data : \$data;
  $self->{_data_ref} = $ref;
  $self->{_internal} = undef;
  return $self;
}

sub append {
  my $self = shift;
  my $data = $_[0];
  my $ref;
  if (ref($data) eq 'ARIBString') {
    $ref = $data->{_data_ref};
  } else {
    $ref = ref($data) ? $data : \$data;
  }
  ${$self->{_data_ref}} .= $$ref;
  $self->{_internal} = undef;
  $self;
}

sub as_string {
  my $self = shift;
  $self->{_internal} = $self->raw(${$self->{_data_ref}}) unless ($self->{_internal});
  return $self->{_internal};
}

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

sub PutKanji        {Encode::decode('jis0208-raw', pack("n", shift))}
sub PutHiragana     {$symbols{hiragana}[(shift) - 0x21]}
sub PutKatakana     {$symbols{katakana}[(shift) - 0x21]}
sub PutJisKatakana  {$symbols{jisx_0201_katakana}[(shift) - 0x21]}
sub PutAlphaNumeric {$symbols{alnum}[(shift) - 0x21]}
sub PutMosaicA      { }
sub PutMosaicB      { }
sub PutMosaicC      { }
sub PutMosaicD      { }
sub PutDRCS0        { }
sub PutDRCS1        { }
sub PutDRCS2        { }
sub PutDRCS3        { }
sub PutDRCS4        { }
sub PutDRCS5        { }
sub PutDRCS6        { }
sub PutDRCS7        { }
sub PutDRCS8        { }
sub PutDRCS9        { }
sub PutDRCS10       { }
sub PutDRCS11       { }
sub PutDRCS12       { }
sub PutDRCS13       { }
sub PutDRCS14       { }
sub PutDRCS15       { }
sub PutDRCSMacro    { }

sub PutSymbol {
  my $s  = shift;
  my $ku = ($s >> 8) - 0x20;
  $symbols{$ku}[$s - (0x7521 + 0x100 * ($ku - 85))];
}

my %charsize = (
  \&PutKanji        => 2,
  \&PutHiragana     => 1,
  \&PutKatakana     => 1,
  \&PutAlphaNumeric => 1,
  \&PutSymbol       => 2,
  \&PutMosaicA      => 1,
  \&PutMosaicB      => 1,
  \&PutMosaicC      => 1,
  \&PutMosaicD      => 1,
  \&PutJisKatakana  => 1,
  \&PutDRCS0        => 2,
  \&PutDRCS1        => 1,
  \&PutDRCS2        => 1,
  \&PutDRCS3        => 1,
  \&PutDRCS4        => 1,
  \&PutDRCS5        => 1,
  \&PutDRCS6        => 1,
  \&PutDRCS7        => 1,
  \&PutDRCS8        => 1,
  \&PutDRCS9        => 1,
  \&PutDRCS10       => 1,
  \&PutDRCS11       => 1,
  \&PutDRCS12       => 1,
  \&PutDRCS13       => 1,
  \&PutDRCS14       => 1,
  \&PutDRCS15       => 1,
  \&PutDRCSMacro    => 1,
);

my %gset = (
  0x42 => \&PutKanji,		# 漢字
  0x4a => \&PutAlphaNumeric,	# 英数
  0x30 => \&PutHiragana,	# 平仮名
  0x31 => \&PutKatakana,	# 片仮名
  0x32 => \&PutMosaicA,	# モザイクA
  0x33 => \&PutMosaicB,	# モザイクB
  0x34 => \&PutMosaicC,	# モザイクC
  0x35 => \&PutMosaicD,	# モザイクD
  0x36 => \&PutAlphaNumeric,	# プロポーショナル英数
  0x37 => \&PutHiragana,	# プロポーショナル平仮名
  0x38 => \&PutKatakana,	# プロポーショナル片仮名
  0x39 => \&PutKanji,		# JIS互換漢字1面 (JISX0213:2004 1面)
  0x3a => \&PutKanji,		# JIS互換漢字2面 (JISX0213:2004 2面)
  0x3b => \&PutSymbol,	# 追加記号（ARIB外字）
  0x49 => \&PutJisKatakana,	# JISX0201片仮名
);

my %drcs = (
  0x40 => \&PutDRCS0,		# DRCS-0
  0x41 => \&PutDRCS1,		# DRCS-1
  0x42 => \&PutDRCS2,		# DRCS-2
  0x43 => \&PutDRCS3,		# DRCS-3
  0x44 => \&PutDRCS4,		# DRCS-4
  0x45 => \&PutDRCS5,		# DRCS-5
  0x46 => \&PutDRCS6,		# DRCS-6
  0x47 => \&PutDRCS7,		# DRCS-7
  0x48 => \&PutDRCS8,		# DRCS-8
  0x49 => \&PutDRCS9,		# DRCS-9
  0x4a => \&PutDRCS10,	# DRCS-10
  0x4b => \&PutDRCS11,	# DRCS-11
  0x4c => \&PutDRCS12,	# DRCS-12
  0x4d => \&PutDRCS13,	# DRCS-13
  0x4e => \&PutDRCS14,	# DRCS-14
  0x4f => \&PutDRCS15,	# DRCS-15
  0x70 => \&PutDRCSMacro,	# DRCS-Macro
);

sub raw {
  my $self = shift;
  my @src  = unpack("C*", shift);
  my $dest = '';
  my $gl   = 0;
  my $gr   = 2;
  my $ss   = 0;
  my %ops  = (
    0 => \&PutKanji,
    1 => \&PutAlphaNumeric,
    2 => \&PutHiragana,
    3 => \&PutKatakana,
  );

  while (scalar(@src)) {
    if ($src[0] == 0x0f) {    # LS0
      $gl = 0;
      shift @src;
    } elsif ($src[0] == 0x0e) {    # LS1
      $gl = 1;
      shift @src;
    } elsif ($src[0] == 0x19) {    # SS2
      $ss = 2;
      shift @src;
    } elsif ($src[0] == 0x1d) {    # SS3
      $ss = 3;
      shift @src;
    } elsif ($src[0] == 0x1b) {    # ESC
      if ($src[1] == 0x6e) {       # LS2
        $gl = 2;
        splice(@src, 0, 2);
      } elsif ($src[1] == 0x6f) {    # LS3
        $gl = 3;
        splice(@src, 0, 2);
      } elsif ($src[1] == 0x7e) {    # LS1R
        $gr = 1;
        splice(@src, 0, 2);
      } elsif ($src[1] == 0x7d) {    # LS2R
        $gr = 2;
        splice(@src, 0, 2);
      } elsif ($src[1] == 0x7c) {    # LS3R
        $gr = 3;
        splice(@src, 0, 2);
      } elsif ($src[1] == 0x24) {
        if ($src[2] == 0x28) {       # DRCS2_G0 \x1b\x24\x28\x20\xXX
          $ops{0} = $drcs{$src[4]};
          splice(@src, 0, 5);
        } elsif ($src[2] == 0x29) {
          if ($src[3] == 0x20) {     # DRCS2_G1 \x1b\x24\x29\x20\xXX
            $ops{1} = $drcs{$src[4]};
            splice(@src, 0, 5);
          } else {                   # GSET2_G1 \x1b\x24\x29\xXX
            $ops{1} = $gset{$src[3]};
            splice(@src, 0, 4);
          }
        } elsif ($src[2] == 0x2a) {
          if ($src[3] == 0x20) {     # DRCS2_G2 \x1b\x24\x2a\x20\xXX
            $ops{2} = $drcs{$src[4]};
            splice(@src, 0, 5);
          } else {                   # GSET2_G2 \x1b\x24\x2a\xXX
            $ops{2} = $gset{$src[3]};
            splice(@src, 0, 4);
          }
        } elsif ($src[2] == 0x2b) {
          if ($src[3] == 0x20) {     # DRCS2_G3 \x1b\x24\x2b\x20\xXX
            $ops{3} = $drcs{$src[4]};
            splice(@src, 0, 5);
          } else {                   # GSET2_G3 \x1b\x24\x2b\xXX
            $ops{3} = $gset{$src[3]};
            splice(@src, 0, 4);
          }
        } else {    # GSET2_G0 \x1b\x24\xXX
          $ops{0} = $gset{$src[2]};
          splice(@src, 0, 3);
        }
      } elsif ($src[1] == 0x28) {
        if ($src[2] == 0x20) {    # DRCS1_G0 \x1b\x28\x20\xXX
          $ops{0} = $drcs{$src[3]};
          splice(@src, 0, 4);
        } else {                  # GSET1_G0 \x1b\x28\xXX
          $ops{0} = $gset{$src[2]};
          splice(@src, 0, 3);
        }
      } elsif ($src[1] == 0x29) {
        if ($src[2] == 0x20) {    # DRCS1_G1 \x1b\x29\x20\xXX
          $ops{1} = $drcs{$src[3]};
          splice(@src, 0, 4);
        } else {                  # GSET1_G1 \x1b\x29\xXX
          $ops{1} = $gset{$src[2]};
          splice(@src, 0, 3);
        }
      } elsif ($src[1] == 0x2a) {
        if ($src[2] == 0x020) {    # DRCS1_G2 \x1b\x2a\x20\xXX
          $ops{2} = $drcs{$src[3]};
          splice(@src, 0, 4);
        } else {                   # GSET1_G2 \x1b\x2a\xXX
          $ops{2} = $gset{$src[2]};
          splice(@src, 0, 3);
        }
      } elsif ($src[1] == 0x2b) {
        if ($src[2] == 0x20) {     # DRCS1_G3 \x1b\x2b\x20\xXX
          $ops{3} = $drcs{$src[3]};
          splice(@src, 0, 4);
        } else {                   # GSET1_G3 \x1b\x2b\xXX
          $ops{3} = $gset{$src[2]};
          splice(@src, 0, 3);
        }
      } else {
        map {printf STDERR "%02x", $_} @src;
        print STDERR "\n";
        last;
      }
    } elsif ($src[0] == 0x89) {    # MSZ
      shift @src;
    } elsif ($src[0] == 0x8a) {    # NSZ
      shift @src;
    } elsif ($src[0] == 0x20 or $src[0] == 0xa0) {    # SPC
      $dest .= " ";
      shift @src;
    } elsif ($src[0] >= 0x21 and $src[0] <= 0x7e) {    # GL
      my $op = $ss ? $ops{$ss} : $ops{$gl};
      my $size = $charsize{$op};
      $ss = 0;
      if (scalar(@src) >= $size) {
        my $data = $size == 1 ? $src[0] : ($src[0] << 8) + $src[1];
        $dest .= &$op($data & 0x7f7f) || '';
      }
      splice(@src, 0, $size);
    } elsif ($src[0] >= 0xa1 and $src[0] <= 0xfe) {    # GR
      my $op   = $ops{$gr};
      my $size = $charsize{$op};
      if (scalar(@src) >= $size) {
        my $data = $size == 1 ? $src[0] : ($src[0] << 8) + $src[1];
        $dest .= &$op($data & 0x7f7f) || '';
      }
      splice(@src, 0, $size);
    } else {
      shift @src;
    }
  }
  return $dest;
}

1;
