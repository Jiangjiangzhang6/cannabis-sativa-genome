#!/usr/bin/perl
#use strict;
use warnings;

while (<>) {
    chomp; # 去掉每行末尾的换行符

    if (/^>/) { # 检查是否以 '>' 开头
        s/#Unknown___//; # 去掉 # 后的 Unknown___
	# 进行模式匹配和替换
        s/ClassI_LTR_(\w+)/LTR\/$1/; # 替换 ClassI_后面跟一个单词字符的内容
        s/ClassII_DNA_(\w+)_(\w+)/DNA\/$1-$2/;
	s/ClassII_(\w+)/DNA\/$1/; # 替换 DNA_后面跟一个单词字符的内容
        s/ClassI_nLTR_(\w+)_(\w+)/nLTR\/$1-$2/;
        s/ClassI_nLTR_(\w+)/nLTR\/$1/;
        s/ClassI_LTR/LTR/;
	s/ClassI_nLTR/nLTR/;
	# 使用 \w 和 \s 的示例
        # s/(\w+)\s+(\w+)/$1-$2/; # 用 - 替换两个单词之间的空白

        print "$_\n"; # 输出修改后的行
    } else {
        print "$_\n"; # 直接输出不以 '>' 开头的行
    }
}
