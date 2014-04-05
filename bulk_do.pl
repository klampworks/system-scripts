#!/usr/bin/perl
#
# Given a file, iterate through it and and execure 
# a given command on each line.
#
# Arg 1: Filename
# Arg 2: Command to perform
#

open IN, '<', $ARGV[0] or die "Cant open $ARGV[0]:$!";

while (<IN>) {
	$_ =~  s/\n//;
	print "$ARGV[1] $_\n";
	
	system($ARGV[1], $_);
}
