#!/usr/bin/env/perl

use strict;
use warnings;

use Getopt::Long;
use Text::CSV_XS;
use feature q{say};

# script to parse csv files and dump out contents
# useful base for processing csv data

my $filepath;
GetOptions(
	"filepath=s" => \$filepath
);

my $csv = Text::CSV_XS->new({ binary => 1 });

open(my $fh ,q{<}, $filepath) 
	or die qq{Can't open $filepath};

my @headers = $csv->getline($fh);

while (my $row = $csv->getline_hr($fh)) {
	say $row->{$_} foreach @headers;
}
