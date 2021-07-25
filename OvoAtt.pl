#    M              OOOOOOOO
#    A            OO--------OO
#    D          OO--------VVVVOO
#    E        OOVVVV------VVVVVVOO
#             OOVVVV------VVVVVVOO
#    B      OOVVVVVV--------VVVV--OO
#    Y      OOVVVVVV--------------OO
#         OO----------VVVVVV--------OO
#    O    OO--------VVVVVVVVVV------OO
#    V    OOVVVV----VVVVVVVVVV------OO
#    O    OOVVVVVV--VVVVVVVVVV--VV--OO
#    K      OOVVVV----VVVVVV--VVVVOO
#    O      OOVVVV------------VVVVOO
#    R        OOOO--------------OO
#    E            OO--------OOOO
#    !              OOOOOOOO

use strict;
use WWW::Mechanize;

open RAGEXE, "<", "Ragexe_DP.exe";
binmode RAGEXE;
my ($ragexe, $key1, $key2, $key3);
my ($findPacket, $findKey) = 0;

while (<RAGEXE>) {
	my $line = unpack("H*",$_);
	if ($line =~ /558BEC81ECE00A/i && $findPacket == 0) {
		$findPacket = 1;
	}
	if ($findPacket == 1) {
		$ragexe = "$ragexe$line";
		if ($line =~ /E8A45DFFFF5E8BE55DC3/i) {
			$findPacket = 2;
		}
	}
	if ($line =~ /25FF7F00005DC2040083F801751BC74104(..)(..)(..)(..)C74108(..)(..)(..)(..)C7410C(..)(..)(..)(..)/i) {
		$key1 = "0x" . uc "$4$3$2$1";
		$key2 = "0x" . uc "$12$11$10$9";
		$key3 = "0x" . uc "$8$7$6$5";
		$findKey = 1;
	}
	if ($findPacket == 2 && $findKey == 1) {
		last;
	}
}
close(RAGEXE);

while ($ragexe =~ /C745F.(..)(..)0{4}C745F.(..)(..)0{4}C745F.(..)(..)0{4}C745F.(..)(..)0{4}/ig) {
	$ragexe =~ s/C745F.(..)(..)0{4}C745F.(..)(..)0{4}C745F.(..)(..)0{4}C745F.(..)(..)0{4}/\$$2$1\$$4$3\$$6$5\$$8$7/igm;
}

while ($ragexe =~ /c745f.(..)(..)0{4}c745f.f{8}c745f.(..)(..)0{4}c745f.(..)(..)0{4}/ig) {
	$ragexe =~ s/c745f.(..)(..)0{4}c745f.f{8}c745f.(..)(..)0{4}c745f.(..)(..)0{4}/\$$2$1\$00ff\$$4$3\$$6$5/igm;
}

while ($ragexe =~ /c745f.(..)(..)0{4}.{24}c745f.(..)(..)0{4}c745f.(..)(..)0{4}c745f.(..)(..)0{4}/ig) {
	$ragexe =~ s/c745f.(..)(..)0{4}.{24}c745f.(..)(..)0{4}c745f.(..)(..)0{4}c745f.(..)(..)0{4}/\$$2$1\$$4$3\$$6$5\$$8$7/igm;
}

while ($ragexe =~ /C745F.(..)(..)0{4}c745f.(..)(..)0{4}c745f.(..)(..)0{4}.{24}c745f.(..)(..)0{4}/ig) {
	$ragexe =~ s/C745F.(..)(..)0{4}c745f.(..)(..)0{4}c745f.(..)(..)0{4}.{24}c745f.(..)(..)0{4}/\$$2$1\$$4$3\$$6$5\$$8$7/igm;
}

while ($ragexe =~ /C745F.(..)(..)0{4}c745f.(..)(..)0{4}.{24}c745f.(..)(..)0{4}c745f.(..)(..)0{4}/ig) {
	$ragexe =~ s/C745F.(..)(..)0{4}c745f.(..)(..)0{4}.{24}c745f.(..)(..)0{4}c745f.(..)(..)0{4}/\$$2$1\$$4$3\$$6$5\$$8$7/igm;
}

while ($ragexe =~ /c745f.(..)(..)0{4}c745f.f{8}.{30}c745f.(..)(..)0{4}c745f.(..)(..)0{4}/ig) {
	$ragexe =~ s/c745f.(..)(..)0{4}c745f.f{8}.{30}c745f.(..)(..)0{4}c745f.(..)(..)0{4}/\$$2$1\$00ff\$$4$3\$$6$5/igm;
}

while ($ragexe =~ /c745f.(..)(..)0{4}c745f.(..)(..)0{4}c745f.(..)(..)0{4}.{30}c745f.(..)(..)0{4}/ig) {
	$ragexe =~ s/c745f.(..)(..)0{4}c745f.(..)(..)0{4}c745f.(..)(..)0{4}.{30}c745f.(..)(..)0{4}/\$$2$1\$$4$3\$$6$5\$$8$7/igm;
}

while ($ragexe =~ /c745f.(..)(..)0{4}.{30}c745f.(..)(..)0{4}c745f.(..)(..)0{4}c745f.0{4}/ig) {
	$ragexe =~ s/c745f.(..)(..)0{4}.{30}c745f.(..)(..)0{4}c745f.(..)(..)0{4}c745f.0{4}/\$$2$1\$$4$3\$$6$5\$$8$7/igm;
}

while ($ragexe =~ /8b.{12}6a(..)6a(..)6a(..)68(..)(..)0{4}/ig) {
	$ragexe =~ s/8b.{12}6a(..)6a(..)6a(..)68(..)(..)0{4}/\$$5$4\$00$3\$00$2\$00$1/igm;
}

while ($ragexe =~ /8b.{12}6a(..)68(..)(..)0{4}68(..)(..)0{4}68(..)(..)0{4}/ig) {
	$ragexe =~ s/8b.{12}6a(..)68(..)(..)0{4}68(..)(..)0{4}68(..)(..)0{4}/\$$7$6\$$5$4\$$3$2\$00$1/igm;
}

while ($ragexe =~ /8b.{12}6a(..)6a(..)6a(..)6a(..)/ig) {
	$ragexe =~ s/8b.{12}6a(..)6a(..)6a(..)6a(..)/\$00$4\$00$3\$00$2\$00$1/igm;
}

my $max = 0;
my (@id, @length, @min_length, @repeat);
while ($ragexe =~ /\$(....)\$(....)\$(....)\$(....)/ig) {
	push @id, uc $1;
	if ($2 eq "00ff") {	push @length, "-1";	}
	else {	push @length, uc hex($2);	}
	push @min_length, uc hex($3);
	push @repeat, uc hex($4);
	$max++;
}

mkdir "tables";
mkdir "tables/bRO";
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
$year += 1900;
$mon += 1;
open (my $recvpackets, '>:encoding(UTF-8)', 'tables/bRO/recvpackets.txt');
print $recvpackets "# Packet Extractor by OvoKore\n";
print $recvpackets "# Generated in $hour:$min:$sec - $mday/$mon/$year\n";
print $recvpackets "# Encryption Keys : $key1, $key2, $key3\n";
for (my $i = 0; $i < $max; $i++) {
	if 	  ($i == $max - 197) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# actor_action\n";	}
	elsif ($i == $max - 196) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# skill_use\n";	}
	elsif ($i == $max - 195) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# character_move\n";	}
	elsif ($i == $max - 194) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# sync\n";	}
	elsif ($i == $max - 193) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# actor_look_at\n";	}
	elsif ($i == $max - 192) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# item_take\n";	}
	elsif ($i == $max - 191) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# item_drop\n";	}
	elsif ($i == $max - 190) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# storage_item_add\n";	}
	elsif ($i == $max - 189) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# storage_item_remove\n";	}
	elsif ($i == $max - 188) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# skill_use_location\n";	}
	elsif ($i == $max - 187) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# unknown/unused\n";	}
	elsif ($i == $max - 186) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# actor_info_request\n";	}
	elsif ($i == $max - 185) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# actor_name_request\n";	}
	elsif ($i == $max - 184) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# unknown/unused\n";	}
	elsif ($i == $max - 183) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# unknown/unused\n";	}
	elsif ($i == $max - 182) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# unknown/unused\n";	}
	elsif ($i == $max - 181) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# buy_bulk_buyer\n";	}
	elsif ($i == $max - 180) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# buy_bulk_request\n";	}
	elsif ($i == $max - 179) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# buy_bulk_closeShop\n";	}
	elsif ($i == $max - 178) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# buy_bulk_openShop\n";	}
	elsif ($i == $max - 177) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# booking_register\n";	}
	elsif ($i == $max - 176) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# unknown/unused\n";	}
	elsif ($i == $max - 175) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# item_list_window_selected\n";	}
	elsif ($i == $max - 174) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# map_login\n";	}
	elsif ($i == $max - 173) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# party_join_request_by_name\n";	}
	elsif ($i == $max - 172) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# unknown/unused\n";	}
	elsif ($i == $max - 171) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# friend_request\n";	}
	elsif ($i == $max - 170) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# homunculus_command\n";	}
	elsif ($i == $max - 169) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# storage_password\n";	}
	elsif ($i >= $max - 168 && $i <= $max - 85) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# sync_ex_reply\n";	}
	elsif ($i >= $max - 84 && $i < $max) {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\t# sync_request_ex\n";	}
	else {	print $recvpackets "$id[$i] $length[$i] $min_length[$i] $repeat[$i]\n";	}
}
close $recvpackets;

open (my $shuffle, '>:encoding(UTF-8)', 'tables/bRO/shuffle.txt');
print $shuffle "# Packet Extractor by OvoKore\n";
print $shuffle "# Generated in $hour:$min:$sec - $mday/$mon/$year\n";
for (my $i = $max - 197; $i <= $max - 169; $i++) {
	if ($i == $max - 197) {		print $shuffle "0089 $id[$i]\n";	}
	elsif ($i == $max - 196) {	print $shuffle "0113 $id[$i]\n";	}
	elsif ($i == $max - 195) {	print $shuffle "0437 $id[$i]\n";	}
	elsif ($i == $max - 194) {	print $shuffle "0360 $id[$i]\n";	}
	elsif ($i == $max - 193) {	print $shuffle "0361 $id[$i]\n";	}
	elsif ($i == $max - 192) {	print $shuffle "0362 $id[$i]\n";	}
	elsif ($i == $max - 191) {	print $shuffle "0363 $id[$i]\n";	}
	elsif ($i == $max - 190) {	print $shuffle "0364 $id[$i]\n";	}
	elsif ($i == $max - 189) {	print $shuffle "0365 $id[$i]\n";	}
	elsif ($i == $max - 188) {	print $shuffle "0366 $id[$i]\n";	}
	elsif ($i == $max - 187) {	print $shuffle "0367 $id[$i]\n";	}
	elsif ($i == $max - 186) {	print $shuffle "0368 $id[$i]\n";	}
	elsif ($i == $max - 185) {	print $shuffle "0369 $id[$i]\n";	}
	elsif ($i == $max - 184) {	print $shuffle "083C $id[$i]\n";	}
	elsif ($i == $max - 183) {	print $shuffle "0838 $id[$i]\n";	}
	elsif ($i == $max - 182) {	print $shuffle "0835 $id[$i]\n";	}
	elsif ($i == $max - 181) {	print $shuffle "0819 $id[$i]\n";	}
	elsif ($i == $max - 180) {	print $shuffle "0817 $id[$i]\n";	}
	elsif ($i == $max - 179) {	print $shuffle "0815 $id[$i]\n";	}
	elsif ($i == $max - 178) {	print $shuffle "0811 $id[$i]\n";	}
	elsif ($i == $max - 177) {	print $shuffle "0802 $id[$i]\n";	}
	elsif ($i == $max - 176) {	print $shuffle "07EC $id[$i]\n";	}
	elsif ($i == $max - 175) {	print $shuffle "07E4 $id[$i]\n";	}
	elsif ($i == $max - 174) {	print $shuffle "0436 $id[$i]\n";	}
	elsif ($i == $max - 173) {	print $shuffle "02C4 $id[$i]\n";	}
	elsif ($i == $max - 172) {	print $shuffle "0281 $id[$i]\n";	}
	elsif ($i == $max - 171) {	print $shuffle "0202 $id[$i]\n";	}
	elsif ($i == $max - 170) {	print $shuffle "022D $id[$i]\n";	}
	elsif ($i == $max - 169) {	print $shuffle "023B $id[$i]\n";	}
}
close $shuffle;

my (@reply, @request);
open (my $sync, '>:encoding(UTF-8)', 'tables/bRO/sync.txt');
print $sync "# Packet Extractor by OvoKore\n";
print $sync "# Generated in $hour:$min:$sec - $mday/$mon/$year\n";
for (my $i = $max - 168; $i < $max; $i++) {
	if ($i >= $max - 168 && $i <= $max - 85) {		push @reply, $id[$i];	}
	elsif ($i >= $max - 84 && $i < $max) {	push @request, $id[$i];	}
}
for (my $i = 0; $i < @reply; $i++) {
	print $sync uc "$reply[$i] $request[$i]\n";
}
close $sync;

my $mech = WWW::Mechanize->new();
$mech->get('https://raw.githubusercontent.com/OpenKore/openkore/master/tables/servers.txt');
my $texto = $mech->content;
$texto =~ s/(\[Brazil(.+[\r\n]+){17}sendCryptKeys ).*/$1$key1, $key2, $key3/igm;
open (my $servers, '>:encoding(UTF-8)', 'tables/servers.txt');
print $servers $texto;
close $servers;