#!/usr/bin/perl
my $id;
open IN, "< consensi.fa.classified";
open OUT1,"> un.fa";
open OUT2,"> no_un.fa";
while(my $str = <IN>){
chomp $str;
if($str =~ /^>/ && $str =~ m/Unknown/i){
print OUT1 "$str\n";$id = 1;next;
}elsif($str =~ /^>/ && $str !~ m/Unknown/i)
{print OUT2 "$str\n";$id = 2;next;}
elsif($id eq 1){print OUT1 "$str\n";}
elsif($id eq 2){print OUT2 "$str\n";}
}
close IN;
close OUT1;
close OUT2;
