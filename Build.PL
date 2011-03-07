#!/usr/bin/env perl

use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
	build_requires => {
		'Test::More' => 0,
		'Test::Compile' => 0,
		'Test::Pod' => 0,
	},
	dist_abstract => 'Cheap PNG widgets for the lulz',
	dist_name => 'visual',
	dist_version => '0.0',
	license => 'unrestricted',
	PL_files => {
		'lib/Derf/Visual/WeatherIcons.pm.PL' =>
			'lib/Derf/Visual/WeatherIcons.pm',
	},
	requires => {
		'perl' => '5.10.0',
		'autodie' => 0,
	},
	sign => 1,
);
$build->create_build_script();
