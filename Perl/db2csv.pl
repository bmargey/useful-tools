#!/usr/bin/env/perl

use strict;
use warnings;

use DBI;
use File::Temp;
use File::Copy;
use Text::CSV_XS;

=pod

Example script to generate a CSV file from values in an SQLite
database.

=cut

my $args = {
	dbnm => q{dbname},
	host => q{hostname},
	user => q{username},
	pass => q{secret},
	port => 9999
};

# declare file handle and CSV object
my $fh = File::Temp->new;
my $csv = Text::CSV_XS->new({
	eol 	=> "\r\n",
	binary 	=> 1
}); 

# to connect to a SQLite DB
my $dsn = sprintf(
	"dbi:SQLite:%s@%s:%s",
	$args->{dbnm},
	$args->{host},
	$args->{port}
);

my $dbh = DBI->connect( $dsn, $args->{user}, $args->{pass} )
	or die $DBI::errstr;

# run sql query
my $query = $dbh->prepare(
	qq{
		SELECT *
		FROM my_table
	}
);
$query->execute;

# write headers
my @header_row = @{$query->{NAME}};
$csv->print($fh, \@header_row); 

# loop results
while (my $row = $query->fetchrow_hashref) {

	my @row = @{$row}{@header_row};
	$csv->print($fh, \@row);
}

# flush and write to location
$fh->flush;
my $filename = q{Db_results.csv}
copy($fh->filename, q{/Users/user/Documents/} . $filename);