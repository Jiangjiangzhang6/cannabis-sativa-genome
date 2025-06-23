#!/usr/bin/perl
our %hb;
open IN, "< intact.list";
while(my $str = <IN>){
chomp $str;
my @arr = split /\t/,$str;
$hb{$arr[0]} = $arr[1];
}
close IN;
open IN1,"< intact.ltr.pos.list";
while(my $str1 = <IN1>){
chomp $str1;
my @arr1 = split /\s+/,$str1;
if(exists $hb{$arr1[0]}){
print "$str1\t$hb{$arr1[0]}\n";
}
}
close IN1;
