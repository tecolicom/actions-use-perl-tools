#!/usr/bin/env perl

use strict;
use warnings;

my @bin;
my %bin;

for (@INC) {
    while (m{/lib/}gp) {
	my $bin = "${^PREMATCH}/bin";
	next if $bin{$bin}++;
	push @bin, $bin;
    }
}

for my $path (split /:+/, $ENV{PATH}) {
    push @bin, $path unless $bin{$path};
}

print join " ", @INC, @bin;
