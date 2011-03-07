#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use autodie;
use MIME::Base64 qw(encode_base64);

my ($out_file) = @ARGV;
my $share_dir = 'share/weather';

open(my $out_fh, '>', $out_file);
opendir(my $share_dh, $share_dir);

print {$out_fh} <DATA>;

for my $file (readdir($share_dh)) {
	if (not -l "${share_dir}/${file}") {
		next;
	}

	open(my $fh, '<', "${share_dir}/${file}");
	my $content = do { local $/ = undef; <$fh> };
	close($fh);

	printf {$out_fh} (
		"______[ %s ]______\n%s\n",
		$file,
		encode_base64($content),
	);
}
closedir($share_dh);
close($out_fh);


__DATA__
package Derf::Visual::WeatherIcons;
use strict;
use warnings;
use base 'Exporter';
use Data::Section -setup;
use MIME::Base64 qw(decode_base64);

our @EXPORT_OK = ();
our $VERSION = '0.1';

sub new {
	my ($obj) = @_;
	my $ref = {};
	return bless($ref, $obj);
}

sub exists {
	my ($self, $name) = @_;

	if (defined $self->section_data($name)) {
		return 1;
	}
	return 0;
}

sub get {
	my ($self, $name) = @_;
	my $data = $self->section_data($name);

	if (not $data) {
		return undef;
	}

	return decode_base64(${$data});
}

1;

__DATA__
