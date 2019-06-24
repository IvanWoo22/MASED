use strict;
use warnings;

open GFF,"<", $ARGV[0];
open OGF,">", $ARGV[1];

my @name;

while(<GFF>){
	chomp;
	my @tmp = split(/\t/,$_);
	if($tmp[0] =~ /scaffold_([1-8])/){
		$tmp[3] =~ /Name=Carub\.(\w+)/;
		my $name = $1;
		push(@name,$name);
		$tmp[0] =~ /scaffold_([1-8])/;
		my $sc = $1;
		if($tmp[4] eq "+"){
			print OGF "Crub_Sc$sc\t$name\t$tmp[1]\t$tmp[2]\n";
		}else{
			print OGF "Crub_Sc$sc\t$name\t$tmp[2]\t$tmp[1]\n";
		}
	}
}
close OGF;
close GFF;

open PEP, "<", $ARGV[2];
my @pep = <PEP>;
close PEP;

foreach my $i (0..$#name){
	my $j = 0;
	until(($j > $#pep) or ($pep[$j] =~ />Carub\.$name[$i]\.1\.p/)){
		$j++;
	}
	if($j <= $#pep){
		print">$name[$i]\n";
		my $k = 1;
		until(($j+$k > $#pep) or ($pep[$j+$k] =~ /^>/)){
			print"$pep[$j+$k]";
			$k++;
		}
		splice(@pep,$j,$k);
	}
}