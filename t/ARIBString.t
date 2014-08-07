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

my $src = pack("H*", "40243326c7306c4856487eb7a43d5634561b7ea81b7dc8ad1b7ea9b1b0ede9eeae215647721b7da448414125ac66461b7ea81b7dab1b7ea91b7db1eb3d56345621211b7cc9d0a421571b242a3b1b7dfa");

#ok(ARIBString::utf8($src) eq '世界で一番美しい瞬間(とき)1min.「白い帆船が翔(か)ける瞬間　ドバイ」');
ok(ARIBString::utf8($src) eq '世界で一番美しい瞬間（とき）１０ｍｉｎ．「白い帆船が翔（か）ける瞬間　ドバイ」');
