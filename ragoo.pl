#!/bin/perl
open IN, "<$ARGV[0]";
while(my $str = <IN>){
chomp $str;
if($str !~ /^>/){
my @arr = split /N+/, $str;
for $wangfei (@arr){
$n++;
print ">yuanbao$n\n$wangfei\n";
}}else{}}
close IN;
