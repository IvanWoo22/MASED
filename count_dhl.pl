##################################
# count_dhl.pl
# It is a Perl script by Ivan_Woo
# It count each kind of meth level of segment duplication
# 2019-05-12
##################################

use strict;
use warnings;


open AT_CR,"<",$ARGV[0];
open CR_BR,"<",$ARGV[1];
open BR_TC,"<",$ARGV[2];
open BTC,"<",$ARGV[3];

my $h = $ARGV[4];
my $d = $ARGV[5];

my $atcr = 0;
my $atcr_h = 0;
my $atcr_d = 0;
my $atcr_l = 0;

my $crbr = 0;
my $crbr_h = 0;
my $crbr_d = 0;
my $crbr_l = 0;

my $brtc = 0;
my $brtc_h = 0;
my $brtc_d = 0;
my $brtc_l = 0;

my $btc = 0;
my $btc_h = 0;
my $btc_d = 0;
my $btc_l = 0;

while(<AT_CR>){
	$atcr++;
	chomp;
	my @tmp = split("\t",$_);
	my $o = abs($tmp[4]-$tmp[5]);
	if($o >= $d){
		$atcr_d++;
	}elsif(($o >= $d-0.1)and(($tmp[4]<$h)or($tmp[5]<$h))){
		$atcr_d++;
	}elsif(($tmp[4]>=$h)and($tmp[5]>=$h)){
		$atcr_h++;
	}else{
		$atcr_l++;
	}
}
close AT_CR;

while(<CR_BR>){
	$crbr++;
	chomp;
	my @tmp = split("\t",$_);
	my $o = abs($tmp[4]-$tmp[5]);
	if($o >= $d){
		$crbr_d++;
	}elsif(($o >= $d-0.1)and(($tmp[4]<$h)or($tmp[5]<$h))){
		$crbr_d++;
	}elsif(($tmp[4]>=$h)and($tmp[5]>=$h)){
		$crbr_h++;
	}else{
		$crbr_l++;
	}
}
close CR_BR;

while(<BR_TC>){
	$brtc++;
	chomp;
	my @tmp = split("\t",$_);
	my $o = abs($tmp[4]-$tmp[5]);
	if($o >= $d){
		$brtc_d++;
	}elsif(($o >= $d-0.1)and(($tmp[4]<$h)or($tmp[5]<$h))){
		$brtc_d++;
	}elsif(($tmp[4]>=$h)and($tmp[5]>=$h)){
		$brtc_h++;
	}else{
		$brtc_l++;
	}
}
close BR_TC;

while(<BTC>){
	$btc++;
	chomp;
	my @tmp = split("\t",$_);
	my $o = abs($tmp[4]-$tmp[5]);
	if($o >= $d){
		$btc_d++;
	}elsif(($o >= $d-0.1)and(($tmp[4]<$h)or($tmp[5]<$h))){
		$btc_d++;
	}elsif(($tmp[4]>=$h)and($tmp[5]>=$h)){
		$btc_h++;
	}else{
		$btc_l++;
	}
}
close BTC;


print"$atcr\t$atcr_h\t$atcr_d\t$atcr_l\n$crbr\t$crbr_h\t$crbr_d\t$crbr_l\n$brtc\t$brtc_h\t$brtc_d\t$brtc_l\n$btc\t$btc_h\t$btc_d\t$btc_l\n";

