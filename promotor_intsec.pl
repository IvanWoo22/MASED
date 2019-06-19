use strict;
use warnings;
use AlignDB::IntSpan;

my @chr_set;
foreach(1..5){
	$chr_set[$_] = AlignDB::IntSpan->new;
}

open GFF,"<",$ARGV[0];
while(<GFF>){
	chomp;
	my @tmp = split("\t",$_);
    my $chr = $tmp[0];
	my $start = $tmp[1];
	my $end = $tmp[2];
	$chr_set[$chr]->add_pair($start, $end);
}
close GFF;

my %cov = ( "I"=>1, "II"=>2, "III"=>3, "IV"=>4, "V"=>5 );


open SEG,"<",$ARGV[1];
while(<SEG>){
	chomp;
	my @tmp = split(" ",$_);
	my $set1 = AlignDB::IntSpan->new;
	my $set2 = AlignDB::IntSpan->new;
	$set1->add_pair($tmp[1],$tmp[2]);
	$set2->add_pair($tmp[4],$tmp[5]);
	my $intsec1 = $set1->intersect( $chr_set[$cov{$tmp[0]}] );
	my $intsec2 = $set2->intersect( $chr_set[$cov{$tmp[3]}] );
	if(($intsec1->cardinality >= 5) and ($intsec2->cardinality >= 5)){
		my $s1 = $intsec1->min - 10;
		my $e1 = $intsec1->max + 10;
		my $s2 = $intsec2->min - 10;
		my $e2 = $intsec2->max + 10;
		print"$tmp[0] $s1 $e1 $tmp[3] $s2 $e2\n";
	}
}
close SEG;
