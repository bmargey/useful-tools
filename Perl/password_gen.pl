#!usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use feature q{say};

my ($l, $n, $a);
GetOptions (
	"l=i"	=> \$l, # length of password
	"n" 	=> \$n, # incl. numbers
	"a"	=> \$a # inlc. more than alnum chars 
);
$l = 8 unless $l;

my $pass;
my @set = @{get_subset($n, $a)};

for (0..($l - 1)) {
	$pass .= $set[rand @set];
};
say $pass;

sub get_subset {
	
	my ($n, $a) = @_;
	my @range = ('a'..'z', 'A'..'Z');
	
	return \@range unless $n && $a;
	
	@range = (@range, 0..9) if $n;
	@range = (@range, qw{- + / \ : ; ( ) [ ] @ £ $ % ! = *}) if $a;
	
	return \@range;
};