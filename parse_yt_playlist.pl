#!/usr/bin/perl 

open my $IN, '<', "input";

my @total;
while (<$IN>) {
	
	my @res = ($_ =~ m/\"(\/watch[^\"]+)\"/g);
	@total = (@res, @total);
}

@total =  keys %{{ map { $_ => 1 } @total }};

foreach (@total) {
	print "http://youtube.com$_\n";
}

close $IN;
