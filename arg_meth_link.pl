use strict;
use warnings;
use AlignDB::IntSpan;

open IN,"<", $ARGV[0];
open RL,"<", $ARGV[1];
open LK,"<", $ARGV[1];
open OT,">", $ARGV[2];

my @sit_chr;
my @chr_rl;
my %sit_meth;
foreach(1..5){
	$sit_chr[$_] = AlignDB::IntSpan->new;
	$chr_rl[$_] = AlignDB::IntSpan->new;
}

while(<IN>){
	chomp;
	my @tmp = split(/\t/,$_);
	$sit_chr[$tmp[0]]->add($tmp[1]);
	my $tmp = $tmp[0]."S".$tmp[1];
	$sit_meth{$tmp} = $tmp[3];
}
close IN;


my %cov = ("I"=>1,"II"=>2,"III"=>3,"IV"=>4,"V"=>5);

while(<RL>){
	chomp;
	my @lin = split(" ",$_);
	$chr_rl[$cov{$lin[0]}]->add_pair($lin[1],$lin[2]);
	$chr_rl[$cov{$lin[3]}]->add_pair($lin[4],$lin[5]);
}
close RL;

while(<LK>){
	chomp;
	my @lin = split(" ",$_);
	my $set1 = AlignDB::IntSpan->new;
	my $set2 = AlignDB::IntSpan->new;
	my $env1_tmp = AlignDB::IntSpan->new;
	my $env2_tmp = AlignDB::IntSpan->new;
	my $env1 = AlignDB::IntSpan->new;
	my $env2 = AlignDB::IntSpan->new;
	$set1->add_pair($lin[1],$lin[2]);
	$env1_tmp->add_pair($lin[1]-2000,$lin[1]-1);
	$env1_tmp->add_pair($lin[2]+1,$lin[2]+2000);
	$env1 = $env1_tmp->diff($chr_rl[$cov{$lin[0]}]);
	$env2_tmp->add_pair($lin[4]-2000,$lin[4]-1);
	$env2_tmp->add_pair($lin[5]+1,$lin[5]+2000);
	$env2 = $env2_tmp->diff($chr_rl[$cov{$lin[3]}]);
	$set2->add_pair($lin[4],$lin[5]);
	my $sum1 = $sit_chr[$cov{$lin[0]}]->overlap($set1);
	my $sum2 = $sit_chr[$cov{$lin[3]}]->overlap($set2);
	if(($sum1 > 4) and ($sum2 > 4)){
		my @intsec1 = $sit_chr[$cov{$lin[0]}]->intersect($set1)->as_array;
		my @intsec2 = $sit_chr[$cov{$lin[3]}]->intersect($set2)->as_array;
		my @envintsec1 = $sit_chr[$cov{$lin[0]}]->intersect($env1)->as_array;
		my @envintsec2 = $sit_chr[$cov{$lin[3]}]->intersect($env2)->as_array;

		my $meth1 = 0;
		foreach(0..$#intsec1){
			my $tmp = $cov{$lin[0]}."S".$intsec1[$_];
			$meth1 += $sit_meth{$tmp};
		}
		my $arg_meth1 = $meth1/($#intsec1+1);
	
		my $meth2 = 0;
		foreach(0..$#intsec2){
			my $tmp = $cov{$lin[3]}."S".$intsec2[$_];
			$meth2 += $sit_meth{$tmp};
		}
		my $arg_meth2 = $meth2/($#intsec2+1);
		
		my $meth3 = 0;
		my $arg_meth3;
		if(@envintsec1){
			foreach(0..$#envintsec1){
				my $tmp = $cov{$lin[0]}."S".$envintsec1[$_];
				$meth3 += $sit_meth{$tmp};
			}
			$arg_meth3 = $meth3/($#envintsec1+1);
		}else{
			$arg_meth3 = 0;
		}
	
		my $meth4 = 0;
		my $arg_meth4;
		if(@envintsec2){
			foreach(0..$#envintsec2){
				my $tmp = $cov{$lin[3]}."S".$envintsec2[$_];
				$meth4 += $sit_meth{$tmp};
			}
			$arg_meth4 = $meth4/($#envintsec2+1);
		}else{
			$arg_meth4 = 0;
		}

		my $delta = $arg_meth2 - $arg_meth1;
		print OT "$_\t$delta\t$sum1\t$sum2\t$arg_meth1\t$arg_meth2\t$arg_meth3\t$arg_meth4\n";
	}
}
close LK;
close OT;