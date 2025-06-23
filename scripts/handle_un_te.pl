#!/usr/bin/perl
%hb;
open IN,"<./opt_DeepTE.fasta";
while(my $str = <IN>){
chomp $str;
if($str =~ /^>/){
$str =~ s/>//;
my @arr = split /#/,$str;
$arr[1] =~ s/Unknown__//;
$hb{$arr[0]} = $arr[1];
}}
close IN;
open IN,"< un.fa";
while(my $str = <IN>){
chomp $str;
if($str =~ /^>/){
$str =~ s/>//;
my @arr = split /#/,$str;
my @arr1= split (/\s+/,$arr[1],2);
if(exists $hb{$arr[0]}){
print ">$arr[0]#$hb{$arr[0]} $arr1[1]\n";
}}else{
print "$str\n";
}}
close IN;
