##################################
# count_dhl.pl
# It is a Perl script by Ivan_Woo
# It count each kind of meth level of segment duplication
# 2019-05-12
##################################

use strict;
use warnings;


open AT_CR,"<",$ARGV[0];

my $d = $ARGV[1];

my $atcr = 0;
my $atcr_d = 0;
my $atcr_l = 0;

while(<AT_CR>){
	$atcr++;
	chomp;
	my @tmp = split("\t",$_);
	my $o;
	if (($tmp[4]>0) and ($tmp[5]>0)){
		$o = abs($tmp[4]-$tmp[5])/($tmp[4]+$tmp[5]);
	}else{
		$o = 0;
	}
	if($o >= $d){
		$atcr_d++;
	}else{
		$atcr_l++;
	}
}
close AT_CR;

print"$atcr\t$atcr_d\t$atcr_l\n";

