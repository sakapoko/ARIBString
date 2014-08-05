# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl ARIBString.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('ARIBString') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.
my $src = pack("C*", 0x1d, 0x4b, 0x1d, 0x65, 0xf9, 0x1d, 0x39, 0xfe, 0x35, 0x24, 0x3e, 0x5d, 0x3e, 0x70, 0x4a, 0x73);

ok(ARIBString::utf8($src) eq 'ニュース・気象情報');
