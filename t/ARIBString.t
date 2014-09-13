# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl ARIBString.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use utf8;

use Test::More;
BEGIN { use_ok('ARIBString') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

# LS0/GL/Kanji
ok(ARIBString->raw(pack("H*", "0f302130223023")) eq "亜唖娃");

# LS1/GL/AphaNumeric
ok(ARIBString->raw(pack("H*", "0e21222324")) eq "！”＃＄"); # $symbols{alnum}

# SS2/GL/Hiragana
ok(ARIBString->raw(pack("H*", "1921192219231924")) eq "ぁあぃい"); # $symbols{hiragana}

# SS3/GL/KataKana
ok(ARIBString->raw(pack("H*", "1d211d221d231d24")) eq "ァアィイ"); # $symbols{katakana}

# ESC/LS2/GL/Hiragana
ok(ARIBString->raw(pack("H*", "1b6e21222324")) eq "ぁあぃい"); 

# ESC/LS3/GL/Katakana
ok(ARIBString->raw(pack("H*", "1b6f21222324")) eq "ァアィイ"); 

# ESC/LS1R/GR/AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b7ea1a2")) eq "！”");

# ESC/LS2R/GR/Hiragana
ok(ARIBString->raw(pack("H*", "1b7da1a2a3a4")) eq "ぁあぃい");

# ESC/LS3R/GR/Katakana
ok(ARIBString->raw(pack("H*", "1b7ca1a2a3a4")) eq "ァアィイ");

# ESC/DRCS2_G0/DRCS-0/LS0/DRCS0 ~ DRCSMacro not implemented
ok(ARIBString->raw(pack("H*", "1b242820400f2122")) eq ""); # DRCS0
ok(ARIBString->raw(pack("H*", "1b242820410f21")) eq ""); # DRCS1
ok(ARIBString->raw(pack("H*", "1b242820420f21")) eq ""); # DRCS2
ok(ARIBString->raw(pack("H*", "1b242820430f21")) eq ""); # DRCS3
ok(ARIBString->raw(pack("H*", "1b242820440f21")) eq ""); # DRCS4
ok(ARIBString->raw(pack("H*", "1b242820450f21")) eq ""); # DRCS5
ok(ARIBString->raw(pack("H*", "1b242820460f21")) eq ""); # DRCS6
ok(ARIBString->raw(pack("H*", "1b242820470f21")) eq ""); # DRCS7
ok(ARIBString->raw(pack("H*", "1b242820480f21")) eq ""); # DRCS8
ok(ARIBString->raw(pack("H*", "1b242820490f21")) eq ""); # DRCS9
ok(ARIBString->raw(pack("H*", "1b2428204a0f21")) eq ""); # DRCS10
ok(ARIBString->raw(pack("H*", "1b2428204b0f21")) eq ""); # DRCS11
ok(ARIBString->raw(pack("H*", "1b2428204c0f21")) eq ""); # DRCS12
ok(ARIBString->raw(pack("H*", "1b2428204d0f21")) eq ""); # DRCS13
ok(ARIBString->raw(pack("H*", "1b2428204e0f21")) eq ""); # DRCS14
ok(ARIBString->raw(pack("H*", "1b2428204f0f21")) eq ""); # DRCS15
ok(ARIBString->raw(pack("H*", "1b242820700f21")) eq ""); # DRCSMacro

# ESC/DRCS2_G1/DRCS-0/LS1/DRCS0 ~ DRCSMacro not implemented
ok(ARIBString->raw(pack("H*", "1b242920400e2122")) eq ""); # DRCS0
ok(ARIBString->raw(pack("H*", "1b242920410e21")) eq ""); # DRCS1
ok(ARIBString->raw(pack("H*", "1b242920420e21")) eq ""); # DRCS2
ok(ARIBString->raw(pack("H*", "1b242920430e21")) eq ""); # DRCS3
ok(ARIBString->raw(pack("H*", "1b242920440e21")) eq ""); # DRCS4
ok(ARIBString->raw(pack("H*", "1b242920450e21")) eq ""); # DRCS5
ok(ARIBString->raw(pack("H*", "1b242920460e21")) eq ""); # DRCS6
ok(ARIBString->raw(pack("H*", "1b242920470e21")) eq ""); # DRCS7
ok(ARIBString->raw(pack("H*", "1b242920480e21")) eq ""); # DRCS8
ok(ARIBString->raw(pack("H*", "1b242920490e21")) eq ""); # DRCS9
ok(ARIBString->raw(pack("H*", "1b2429204a0e21")) eq ""); # DRCS10
ok(ARIBString->raw(pack("H*", "1b2429204b0e21")) eq ""); # DRCS11
ok(ARIBString->raw(pack("H*", "1b2429204c0e21")) eq ""); # DRCS12
ok(ARIBString->raw(pack("H*", "1b2429204d0e21")) eq ""); # DRCS13
ok(ARIBString->raw(pack("H*", "1b2429204e0e21")) eq ""); # DRCS14
ok(ARIBString->raw(pack("H*", "1b2429204f0e21")) eq ""); # DRCS15
ok(ARIBString->raw(pack("H*", "1b242920700e21")) eq ""); # DRCSMacro

# ESC/GSET2_G1/Kanji/LS1/Kanji - JisKatakana
ok(ARIBString->raw(pack("H*", "1b2429420e3021")) eq "亜"); # Kanji
ok(ARIBString->raw(pack("H*", "1b24294a0e21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b2429300e21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b2429310e21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b2429320e21222324")) eq ""); # MosaicA
ok(ARIBString->raw(pack("H*", "1b2429330e21222324")) eq ""); # MosaicB
ok(ARIBString->raw(pack("H*", "1b2429340e21222324")) eq ""); # MosaicC
ok(ARIBString->raw(pack("H*", "1b2429350e21222324")) eq ""); # MosaicD
ok(ARIBString->raw(pack("H*", "1b2429360e21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b2429370e21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b2429380e21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b2429390e30213022")) eq "亜唖"); # Kanji1
ok(ARIBString->raw(pack("H*", "1b24293a0e30213022")) eq "亜唖"); # Kanji2
ok(ARIBString->raw(pack("H*", "1b24293b0e7521")) eq "㐂"); # Symbol 85ku
ok(ARIBString->raw(pack("H*", "1b24293b0e7622")) eq "秚"); # Symbol 86ku
ok(ARIBString->raw(pack("H*", "1b24293b0e7a50")) eq "【HV】"); # Symbol 90ku
ok(ARIBString->raw(pack("H*", "1b24293b0e7c21")) eq "→"); # Symbol 92ku
ok(ARIBString->raw(pack("H*", "1b24293b0e7d21")) eq "㈪"); # Symbol 93ku
ok(ARIBString->raw(pack("H*", "1b24293b0e7e21")) eq "Ⅰ"); # Symbol 94ku
ok(ARIBString->raw(pack("H*", "1b2429490e21222324")) eq "。「」、"); # JIsKatakana

# ESC/DRCS2_G2/DRCS-0/ESC/LS2/DRCS0 ~ DRCSMacro not implemented
ok(ARIBString->raw(pack("H*", "1b242a20401b6e2122")) eq ""); # DRCS0
ok(ARIBString->raw(pack("H*", "1b242a20411b6e21")) eq ""); # DRCS1
ok(ARIBString->raw(pack("H*", "1b242a20421b6e21")) eq ""); # DRCS2
ok(ARIBString->raw(pack("H*", "1b242a20431b6e21")) eq ""); # DRCS3
ok(ARIBString->raw(pack("H*", "1b242a20441b6e21")) eq ""); # DRCS4
ok(ARIBString->raw(pack("H*", "1b242a20451b6e21")) eq ""); # DRCS5
ok(ARIBString->raw(pack("H*", "1b242a20461b6e21")) eq ""); # DRCS6
ok(ARIBString->raw(pack("H*", "1b242a20471b6e21")) eq ""); # DRCS7
ok(ARIBString->raw(pack("H*", "1b242a20481b6e21")) eq ""); # DRCS8
ok(ARIBString->raw(pack("H*", "1b242a20491b6e21")) eq ""); # DRCS9
ok(ARIBString->raw(pack("H*", "1b242a204a1b6e21")) eq ""); # DRCS10
ok(ARIBString->raw(pack("H*", "1b242a204b1b6e21")) eq ""); # DRCS11
ok(ARIBString->raw(pack("H*", "1b242a204c1b6e21")) eq ""); # DRCS12
ok(ARIBString->raw(pack("H*", "1b242a204d1b6e21")) eq ""); # DRCS13
ok(ARIBString->raw(pack("H*", "1b242a204e1b6e21")) eq ""); # DRCS14
ok(ARIBString->raw(pack("H*", "1b242a204f1b6e21")) eq ""); # DRCS15
ok(ARIBString->raw(pack("H*", "1b242a20701b6e21")) eq ""); # DRCSMacro

# ESC/GSET2_G2/Kanji/ESC/LS2/Kanji - JisKatakana
ok(ARIBString->raw(pack("H*", "1b242a421b6e3021")) eq "亜"); # Kanji
ok(ARIBString->raw(pack("H*", "1b242a4a1b6e21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b242a301b6e21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b242a311b6e21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b242a321b6e21222324")) eq ""); # MosaicA
ok(ARIBString->raw(pack("H*", "1b242a331b6e21222324")) eq ""); # MosaicB
ok(ARIBString->raw(pack("H*", "1b242a341b6e21222324")) eq ""); # MosaicC
ok(ARIBString->raw(pack("H*", "1b242a351b6e21222324")) eq ""); # MosaicD
ok(ARIBString->raw(pack("H*", "1b242a361b6e21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b242a371b6e21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b242a381b6e21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b242a391b6e30213022")) eq "亜唖"); # Kanji1
ok(ARIBString->raw(pack("H*", "1b242a3a1b6e30213022")) eq "亜唖"); # Kanji2
ok(ARIBString->raw(pack("H*", "1b242a3b1b6e7521")) eq "㐂"); # Symbol 85ku
ok(ARIBString->raw(pack("H*", "1b242a3b1b6e7622")) eq "秚"); # Symbol 86ku
ok(ARIBString->raw(pack("H*", "1b242a3b1b6e7a50")) eq "【HV】"); # Symbol 90ku
ok(ARIBString->raw(pack("H*", "1b242a3b1b6e7c21")) eq "→"); # Symbol 92ku
ok(ARIBString->raw(pack("H*", "1b242a3b1b6e7d21")) eq "㈪"); # Symbol 93ku
ok(ARIBString->raw(pack("H*", "1b242a3b1b6e7e21")) eq "Ⅰ"); # Symbol 94ku
ok(ARIBString->raw(pack("H*", "1b242a491b6e21222324")) eq "。「」、"); # JIsKatakana

# ESC/DRCS2_G3/DRCS-0/ESC/LS3/DRCS0 ~ DRCSMacro not implemented
ok(ARIBString->raw(pack("H*", "1b242b20401b6f2122")) eq ""); # DRCS0
ok(ARIBString->raw(pack("H*", "1b242b20411b6f21")) eq ""); # DRCS1
ok(ARIBString->raw(pack("H*", "1b242b20421b6f21")) eq ""); # DRCS2
ok(ARIBString->raw(pack("H*", "1b242b20431b6f21")) eq ""); # DRCS3
ok(ARIBString->raw(pack("H*", "1b242b20441b6f21")) eq ""); # DRCS4
ok(ARIBString->raw(pack("H*", "1b242b20451b6f21")) eq ""); # DRCS5
ok(ARIBString->raw(pack("H*", "1b242b20461b6f21")) eq ""); # DRCS6
ok(ARIBString->raw(pack("H*", "1b242b20471b6f21")) eq ""); # DRCS7
ok(ARIBString->raw(pack("H*", "1b242b20481b6f21")) eq ""); # DRCS8
ok(ARIBString->raw(pack("H*", "1b242b20491b6f21")) eq ""); # DRCS9
ok(ARIBString->raw(pack("H*", "1b242b204a1b6f21")) eq ""); # DRCS10
ok(ARIBString->raw(pack("H*", "1b242b204b1b6f21")) eq ""); # DRCS11
ok(ARIBString->raw(pack("H*", "1b242b204c1b6f21")) eq ""); # DRCS12
ok(ARIBString->raw(pack("H*", "1b242b204d1b6f21")) eq ""); # DRCS13
ok(ARIBString->raw(pack("H*", "1b242b204e1b6f21")) eq ""); # DRCS14
ok(ARIBString->raw(pack("H*", "1b242b204f1b6f21")) eq ""); # DRCS15
ok(ARIBString->raw(pack("H*", "1b242b20701b6f21")) eq ""); # DRCSMacro

# ESC/GSET2_G3/Kanji/ESC/LS3/Kanji - JisKatakana
ok(ARIBString->raw(pack("H*", "1b242b421b6f3021")) eq "亜"); # Kanji
ok(ARIBString->raw(pack("H*", "1b242b4a1b6f21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b242b301b6f21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b242b311b6f21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b242b321b6f21222324")) eq ""); # MosaicA
ok(ARIBString->raw(pack("H*", "1b242b331b6f21222324")) eq ""); # MosaicB
ok(ARIBString->raw(pack("H*", "1b242b341b6f21222324")) eq ""); # MosaicC
ok(ARIBString->raw(pack("H*", "1b242b351b6f21222324")) eq ""); # MosaicD
ok(ARIBString->raw(pack("H*", "1b242b361b6f21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b242b371b6f21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b242b381b6f21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b242b391b6f30213022")) eq "亜唖"); # Kanji1
ok(ARIBString->raw(pack("H*", "1b242b3a1b6f30213022")) eq "亜唖"); # Kanji2
ok(ARIBString->raw(pack("H*", "1b242b3b1b6f7521")) eq "㐂"); # Symbol 85ku
ok(ARIBString->raw(pack("H*", "1b242b3b1b6f7622")) eq "秚"); # Symbol 86ku
ok(ARIBString->raw(pack("H*", "1b242b3b1b6f7a50")) eq "【HV】"); # Symbol 90ku
ok(ARIBString->raw(pack("H*", "1b242b3b1b6f7c21")) eq "→"); # Symbol 92ku
ok(ARIBString->raw(pack("H*", "1b242b3b1b6f7d21")) eq "㈪"); # Symbol 93ku
ok(ARIBString->raw(pack("H*", "1b242b3b1b6f7e21")) eq "Ⅰ"); # Symbol 94ku
ok(ARIBString->raw(pack("H*", "1b242b491b6f21222324")) eq "。「」、"); # JIsKatakana

# ESC/GSET2_G0/Kanji/LS0/Kanji - JisKatakana
ok(ARIBString->raw(pack("H*", "1b24420f3021")) eq "亜"); # Kanji
ok(ARIBString->raw(pack("H*", "1b244a0f21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b24300f21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b24310f21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b24320f21222324")) eq ""); # MosaicA
ok(ARIBString->raw(pack("H*", "1b24330f21222324")) eq ""); # MosaicB
ok(ARIBString->raw(pack("H*", "1b24340f21222324")) eq ""); # MosaicC
ok(ARIBString->raw(pack("H*", "1b24350f21222324")) eq ""); # MosaicD
ok(ARIBString->raw(pack("H*", "1b24360f21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b24370f21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b24380f21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b24390f30213022")) eq "亜唖"); # Kanji1
ok(ARIBString->raw(pack("H*", "1b243a0f30213022")) eq "亜唖"); # Kanji2
ok(ARIBString->raw(pack("H*", "1b243b0f7521")) eq "㐂"); # Symbol 85ku
ok(ARIBString->raw(pack("H*", "1b243b0f7622")) eq "秚"); # Symbol 86ku
ok(ARIBString->raw(pack("H*", "1b243b0f7a50")) eq "【HV】"); # Symbol 90ku
ok(ARIBString->raw(pack("H*", "1b243b0f7c21")) eq "→"); # Symbol 92ku
ok(ARIBString->raw(pack("H*", "1b243b0f7d21")) eq "㈪"); # Symbol 93ku
ok(ARIBString->raw(pack("H*", "1b243b0f7e21")) eq "Ⅰ"); # Symbol 94ku
ok(ARIBString->raw(pack("H*", "1b24490f21222324")) eq "。「」、"); # JIsKatakana

# ESC/DRCS1_G0/DRCS-0/LS0/DRCS0 ~ DRCSMacro not implemented
ok(ARIBString->raw(pack("H*", "1b2820400f2122")) eq ""); # DRCS0
ok(ARIBString->raw(pack("H*", "1b2820410f21")) eq ""); # DRCS1
ok(ARIBString->raw(pack("H*", "1b2820420f21")) eq ""); # DRCS2
ok(ARIBString->raw(pack("H*", "1b2820430f21")) eq ""); # DRCS3
ok(ARIBString->raw(pack("H*", "1b2820440f21")) eq ""); # DRCS4
ok(ARIBString->raw(pack("H*", "1b2820450f21")) eq ""); # DRCS5
ok(ARIBString->raw(pack("H*", "1b2820460f21")) eq ""); # DRCS6
ok(ARIBString->raw(pack("H*", "1b2820470f21")) eq ""); # DRCS7
ok(ARIBString->raw(pack("H*", "1b2820480f21")) eq ""); # DRCS8
ok(ARIBString->raw(pack("H*", "1b2820490f21")) eq ""); # DRCS9
ok(ARIBString->raw(pack("H*", "1b28204a0f21")) eq ""); # DRCS10
ok(ARIBString->raw(pack("H*", "1b28204b0f21")) eq ""); # DRCS11
ok(ARIBString->raw(pack("H*", "1b28204c0f21")) eq ""); # DRCS12
ok(ARIBString->raw(pack("H*", "1b28204d0f21")) eq ""); # DRCS13
ok(ARIBString->raw(pack("H*", "1b28204e0f21")) eq ""); # DRCS14
ok(ARIBString->raw(pack("H*", "1b28204f0f21")) eq ""); # DRCS15
ok(ARIBString->raw(pack("H*", "1b2820700f21")) eq ""); # DRCSMacro

# ESC/GSET1_G0/Kanji/LS0/Kanji - JisKatakana
ok(ARIBString->raw(pack("H*", "1b28420f3021")) eq "亜"); # Kanji
ok(ARIBString->raw(pack("H*", "1b284a0f21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b28300f21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b28310f21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b28320f21222324")) eq ""); # MosaicA
ok(ARIBString->raw(pack("H*", "1b28330f21222324")) eq ""); # MosaicB
ok(ARIBString->raw(pack("H*", "1b28340f21222324")) eq ""); # MosaicC
ok(ARIBString->raw(pack("H*", "1b28350f21222324")) eq ""); # MosaicD
ok(ARIBString->raw(pack("H*", "1b28360f21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b28370f21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b28380f21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b28390f30213022")) eq "亜唖"); # Kanji1
ok(ARIBString->raw(pack("H*", "1b283a0f30213022")) eq "亜唖"); # Kanji2
ok(ARIBString->raw(pack("H*", "1b283b0f7521")) eq "㐂"); # Symbol 85ku
ok(ARIBString->raw(pack("H*", "1b283b0f7622")) eq "秚"); # Symbol 86ku
ok(ARIBString->raw(pack("H*", "1b283b0f7a50")) eq "【HV】"); # Symbol 90ku
ok(ARIBString->raw(pack("H*", "1b283b0f7c21")) eq "→"); # Symbol 92ku
ok(ARIBString->raw(pack("H*", "1b283b0f7d21")) eq "㈪"); # Symbol 93ku
ok(ARIBString->raw(pack("H*", "1b283b0f7e21")) eq "Ⅰ"); # Symbol 94ku
ok(ARIBString->raw(pack("H*", "1b28490f21222324")) eq "。「」、"); # JIsKatakana

# ESC/DRCS1_G1/DRCS-0/LS1/DRCS0 ~ DRCSMacro not implemented
ok(ARIBString->raw(pack("H*", "1b2920400e2122")) eq ""); # DRCS0
ok(ARIBString->raw(pack("H*", "1b2920410e21")) eq ""); # DRCS1
ok(ARIBString->raw(pack("H*", "1b2920420e21")) eq ""); # DRCS2
ok(ARIBString->raw(pack("H*", "1b2920430e21")) eq ""); # DRCS3
ok(ARIBString->raw(pack("H*", "1b2920440e21")) eq ""); # DRCS4
ok(ARIBString->raw(pack("H*", "1b2920450e21")) eq ""); # DRCS5
ok(ARIBString->raw(pack("H*", "1b2920460e21")) eq ""); # DRCS6
ok(ARIBString->raw(pack("H*", "1b2920470e21")) eq ""); # DRCS7
ok(ARIBString->raw(pack("H*", "1b2920480e21")) eq ""); # DRCS8
ok(ARIBString->raw(pack("H*", "1b2920490e21")) eq ""); # DRCS9
ok(ARIBString->raw(pack("H*", "1b29204a0e21")) eq ""); # DRCS10
ok(ARIBString->raw(pack("H*", "1b29204b0e21")) eq ""); # DRCS11
ok(ARIBString->raw(pack("H*", "1b29204c0e21")) eq ""); # DRCS12
ok(ARIBString->raw(pack("H*", "1b29204d0e21")) eq ""); # DRCS13
ok(ARIBString->raw(pack("H*", "1b29204e0e21")) eq ""); # DRCS14
ok(ARIBString->raw(pack("H*", "1b29204f0e21")) eq ""); # DRCS15
ok(ARIBString->raw(pack("H*", "1b2920700e21")) eq ""); # DRCSMacro

# ESC/GSET1_G1/Kanji/LS1/Kanji - JisKatakana
ok(ARIBString->raw(pack("H*", "1b29420e3021")) eq "亜"); # Kanji
ok(ARIBString->raw(pack("H*", "1b294a0e21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b29300e21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b29310e21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b29320e21222324")) eq ""); # MosaicA
ok(ARIBString->raw(pack("H*", "1b29330e21222324")) eq ""); # MosaicB
ok(ARIBString->raw(pack("H*", "1b29340e21222324")) eq ""); # MosaicC
ok(ARIBString->raw(pack("H*", "1b29350e21222324")) eq ""); # MosaicD
ok(ARIBString->raw(pack("H*", "1b29360e21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b29370e21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b29380e21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b29390e30213022")) eq "亜唖"); # Kanji1
ok(ARIBString->raw(pack("H*", "1b293a0e30213022")) eq "亜唖"); # Kanji2
ok(ARIBString->raw(pack("H*", "1b293b0e7521")) eq "㐂"); # Symbol 85ku
ok(ARIBString->raw(pack("H*", "1b293b0e7622")) eq "秚"); # Symbol 86ku
ok(ARIBString->raw(pack("H*", "1b293b0e7a50")) eq "【HV】"); # Symbol 90ku
ok(ARIBString->raw(pack("H*", "1b293b0e7c21")) eq "→"); # Symbol 92ku
ok(ARIBString->raw(pack("H*", "1b293b0e7d21")) eq "㈪"); # Symbol 93ku
ok(ARIBString->raw(pack("H*", "1b293b0e7e21")) eq "Ⅰ"); # Symbol 94ku
ok(ARIBString->raw(pack("H*", "1b29490e21222324")) eq "。「」、"); # JIsKatakana

# ESC/DRCS1_G2/DRCS-0/ESC/LS2/DRCS0 ~ DRCSMacro not implemented
ok(ARIBString->raw(pack("H*", "1b2a20401b6e2122")) eq ""); # DRCS0
ok(ARIBString->raw(pack("H*", "1b2a20411b6e21")) eq ""); # DRCS1
ok(ARIBString->raw(pack("H*", "1b2a20421b6e21")) eq ""); # DRCS2
ok(ARIBString->raw(pack("H*", "1b2a20431b6e21")) eq ""); # DRCS3
ok(ARIBString->raw(pack("H*", "1b2a20441b6e21")) eq ""); # DRCS4
ok(ARIBString->raw(pack("H*", "1b2a20451b6e21")) eq ""); # DRCS5
ok(ARIBString->raw(pack("H*", "1b2a20461b6e21")) eq ""); # DRCS6
ok(ARIBString->raw(pack("H*", "1b2a20471b6e21")) eq ""); # DRCS7
ok(ARIBString->raw(pack("H*", "1b2a20481b6e21")) eq ""); # DRCS8
ok(ARIBString->raw(pack("H*", "1b2a20491b6e21")) eq ""); # DRCS9
ok(ARIBString->raw(pack("H*", "1b2a204a1b6e21")) eq ""); # DRCS10
ok(ARIBString->raw(pack("H*", "1b2a204b1b6e21")) eq ""); # DRCS11
ok(ARIBString->raw(pack("H*", "1b2a204c1b6e21")) eq ""); # DRCS12
ok(ARIBString->raw(pack("H*", "1b2a204d1b6e21")) eq ""); # DRCS13
ok(ARIBString->raw(pack("H*", "1b2a204e1b6e21")) eq ""); # DRCS14
ok(ARIBString->raw(pack("H*", "1b2a204f1b6e21")) eq ""); # DRCS15
ok(ARIBString->raw(pack("H*", "1b2a20701b6e21")) eq ""); # DRCSMacro

# ESC/GSET1_G2/Kanji/ESC/LS2/Kanji - JisKatakana
ok(ARIBString->raw(pack("H*", "1b2a421b6e3021")) eq "亜"); # Kanji
ok(ARIBString->raw(pack("H*", "1b2a4a1b6e21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b2a301b6e21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b2a311b6e21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b2a321b6e21222324")) eq ""); # MosaicA
ok(ARIBString->raw(pack("H*", "1b2a331b6e21222324")) eq ""); # MosaicB
ok(ARIBString->raw(pack("H*", "1b2a341b6e21222324")) eq ""); # MosaicC
ok(ARIBString->raw(pack("H*", "1b2a351b6e21222324")) eq ""); # MosaicD
ok(ARIBString->raw(pack("H*", "1b2a361b6e21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b2a371b6e21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b2a381b6e21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b2a391b6e30213022")) eq "亜唖"); # Kanji1
ok(ARIBString->raw(pack("H*", "1b2a3a1b6e30213022")) eq "亜唖"); # Kanji2
ok(ARIBString->raw(pack("H*", "1b2a3b1b6e7521")) eq "㐂"); # Symbol 85ku
ok(ARIBString->raw(pack("H*", "1b2a3b1b6e7622")) eq "秚"); # Symbol 86ku
ok(ARIBString->raw(pack("H*", "1b2a3b1b6e7a50")) eq "【HV】"); # Symbol 90ku
ok(ARIBString->raw(pack("H*", "1b2a3b1b6e7c21")) eq "→"); # Symbol 92ku
ok(ARIBString->raw(pack("H*", "1b2a3b1b6e7d21")) eq "㈪"); # Symbol 93ku
ok(ARIBString->raw(pack("H*", "1b2a3b1b6e7e21")) eq "Ⅰ"); # Symbol 94ku
ok(ARIBString->raw(pack("H*", "1b2a491b6e21222324")) eq "。「」、"); # JIsKatakana

# ESC/DRCS1_G3/DRCS-0/ESC/LS3/DRCS0 ~ DRCSMacro not implemented
ok(ARIBString->raw(pack("H*", "1b2b20401b6f2122")) eq ""); # DRCS0
ok(ARIBString->raw(pack("H*", "1b2b20411b6f21")) eq ""); # DRCS1
ok(ARIBString->raw(pack("H*", "1b2b20421b6f21")) eq ""); # DRCS2
ok(ARIBString->raw(pack("H*", "1b2b20431b6f21")) eq ""); # DRCS3
ok(ARIBString->raw(pack("H*", "1b2b20441b6f21")) eq ""); # DRCS4
ok(ARIBString->raw(pack("H*", "1b2b20451b6f21")) eq ""); # DRCS5
ok(ARIBString->raw(pack("H*", "1b2b20461b6f21")) eq ""); # DRCS6
ok(ARIBString->raw(pack("H*", "1b2b20471b6f21")) eq ""); # DRCS7
ok(ARIBString->raw(pack("H*", "1b2b20481b6f21")) eq ""); # DRCS8
ok(ARIBString->raw(pack("H*", "1b2b20491b6f21")) eq ""); # DRCS9
ok(ARIBString->raw(pack("H*", "1b2b204a1b6f21")) eq ""); # DRCS10
ok(ARIBString->raw(pack("H*", "1b2b204b1b6f21")) eq ""); # DRCS11
ok(ARIBString->raw(pack("H*", "1b2b204c1b6f21")) eq ""); # DRCS12
ok(ARIBString->raw(pack("H*", "1b2b204d1b6f21")) eq ""); # DRCS13
ok(ARIBString->raw(pack("H*", "1b2b204e1b6f21")) eq ""); # DRCS14
ok(ARIBString->raw(pack("H*", "1b2b204f1b6f21")) eq ""); # DRCS15
ok(ARIBString->raw(pack("H*", "1b2b20701b6f21")) eq ""); # DRCSMacro

# ESC/GSET1_G3/Kanji/ESC/LS3/Kanji - JisKatakana
ok(ARIBString->raw(pack("H*", "1b2b421b6f3021")) eq "亜"); # Kanji
ok(ARIBString->raw(pack("H*", "1b2b4a1b6f21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b2b301b6f21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b2b311b6f21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b2b321b6f21222324")) eq ""); # MosaicA
ok(ARIBString->raw(pack("H*", "1b2b331b6f21222324")) eq ""); # MosaicB
ok(ARIBString->raw(pack("H*", "1b2b341b6f21222324")) eq ""); # MosaicC
ok(ARIBString->raw(pack("H*", "1b2b351b6f21222324")) eq ""); # MosaicD
ok(ARIBString->raw(pack("H*", "1b2b361b6f21222324")) eq "！”＃＄"); # AlphaNumeric
ok(ARIBString->raw(pack("H*", "1b2b371b6f21222324")) eq "ぁあぃい"); # Hiragana
ok(ARIBString->raw(pack("H*", "1b2b381b6f21222324")) eq "ァアィイ"); # Katakana
ok(ARIBString->raw(pack("H*", "1b2b391b6f30213022")) eq "亜唖"); # Kanji1
ok(ARIBString->raw(pack("H*", "1b2b3a1b6f30213022")) eq "亜唖"); # Kanji2
ok(ARIBString->raw(pack("H*", "1b2b3b1b6f7521")) eq "㐂"); # Symbol 85ku
ok(ARIBString->raw(pack("H*", "1b2b3b1b6f7622")) eq "秚"); # Symbol 86ku
ok(ARIBString->raw(pack("H*", "1b2b3b1b6f7a50")) eq "【HV】"); # Symbol 90ku
ok(ARIBString->raw(pack("H*", "1b2b3b1b6f7c21")) eq "→"); # Symbol 92ku
ok(ARIBString->raw(pack("H*", "1b2b3b1b6f7d21")) eq "㈪"); # Symbol 93ku
ok(ARIBString->raw(pack("H*", "1b2b3b1b6f7e21")) eq "Ⅰ"); # Symbol 94ku
ok(ARIBString->raw(pack("H*", "1b2b491b6f21222324")) eq "。「」、"); # JIsKatakana

# broke escape sequence
ok(ARIBString->raw(pack("H*", "1b010203")) eq "");

# MSZ/NSZ/notchar
my $ctl = ARIBString->raw(pack("H*", "898aff"));
ok($ctl eq "");

# space
ok(ARIBString->raw(pack("H*", "20")) eq " ");
ok(ARIBString->raw(pack("H*", "a0")) eq " ");

# GL/Kanji
ok(ARIBString->raw(pack("H*", "3021")) eq "亜");
ok(ARIBString->raw(pack("H*", "30")) eq ""); # drop byte

# short out range
ok(ARIBString->raw(pack("H*", "00")) eq ""); # drop byte

# GR/Kanji (ESC/GSET2_G1/Kanji/LS1R/Kanji)
ok(ARIBString->raw(pack("H*", "1b2429421b7eb0a1")) eq "亜"); # Kanji
ok(ARIBString->raw(pack("H*", "1b2429421b7eb0")) eq ""); # drop byte

# GR/notchar (ESC/GSET2_G1/JisKatakana/LS1R/JisKatakana)
ok(ARIBString->raw(pack("H*", "1b2429491b7ee0")) eq ""); # JIsKatakana map index over

# new
my $a = ARIBString->new(pack("H*", "2422")); # あ
my $b = ARIBString->new(pack("H*", "2424")); # い

# append ARIBString
$a .= $b;
ok($a eq "あい");
# cached convert string
ok($a eq "あい");
my $c = pack("H*", "2426");
# append rawdata
$a .= $c;
ok($a eq "あいう");
# append rawdata reference
$a .= \$c;
ok("$a" eq "あいうう");

# reference
ok(ARIBString->new(\pack("H*", "2422")) eq "あ");

done_testing();
