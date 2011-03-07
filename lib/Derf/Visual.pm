package Derf::Visual;
use strict;
use warnings;
use 5.010;
use base 'Exporter';
use GD;

our @EXPORT_OK = qw(GD_bar);
our $VERSION = '0.1';

sub GD_bar {
	my (%conf) = @_;
	my ($w, $h) = @conf{'width', 'height'};
	my $percent = $conf{percent_filled};
	my $alpha = $conf{alpha};

	my $bar = GD::Image->new($w, $h);

	my ($w_o, $w_w) = ($w * 0.8, $w * 0.9);

	my $black   = $bar->colorAllocateAlpha(  0,   0,   0, $alpha);
	my $gray    = $bar->colorAllocateAlpha(127, 127, 127, $alpha);
	my $lgray   = $bar->colorAllocateAlpha(191, 191, 191, $alpha);
	my $ok_b    = $bar->colorAllocateAlpha(220, 240, 220, $alpha);
	my $ok_f    = $bar->colorAllocateAlpha( 59, 191,  50, $alpha);
	my $wa_b    = $bar->colorAllocateAlpha(240, 240, 220, $alpha);
	my $wa_f    = $bar->colorAllocateAlpha(191, 191,  50, $alpha);
	my $cr_b    = $bar->colorAllocateAlpha(240, 220, 220, $alpha);
	my $cr_f    = $bar->colorAllocateAlpha(191,   0,   0, $alpha);
	my $white   = $bar->colorAllocateAlpha(255, 255, 255, $alpha);

	my $vwidth = sprintf("%d", ($w - 2) * $percent / 100);

	$bar->rectangle(0, 0, $w - 1, $h - 1, $gray);
	$bar->filledRectangle(1, 1, $w   - 2, $h - 2, $cr_b);
	$bar->filledRectangle(1, 1, $w_w - 1, $h - 2, $wa_b);
	$bar->filledRectangle(1, 1, $w_o - 1, $h - 2, $ok_b);
	$bar->filledRectangle(1, 1, $vwidth , $h - 2, $ok_f);

	if ($vwidth > $w_o) {
		$bar->filledRectangle($w_o, 1, $vwidth, $h - 2, $wa_f);
	}

	if ($vwidth > $w_w) {
		$bar->filledRectangle($w_w, 1, $vwidth, $h - 2, $cr_f);
	}

	if ($conf{lined}) {
		for my $i (1 .. $w / $conf{lined}) {
			$bar->line($i * $conf{lined}, 1, $i * $conf{lined}, $h - 2,
				$white);
		}
	}

	return $bar;
}
