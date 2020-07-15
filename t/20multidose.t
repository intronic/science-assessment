#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use DoseMe::ScienceAssessment::Exampillin;
use DoseMe::ScienceAssessment::Role::Drug;

my $ex = DoseMe::ScienceAssessment::Exampillin->new(
    doses => [{
                time => 0,
                k0 => 2000,
                tinf => 0.5
            },
            {
                time => 6,
                k0 => 1000,
                tinf => 1
            },
            {
                time => 12,
                k0 => 1500,
                tinf => 1
            }] );

my $k = $ex->cl() / $ex->vd();
my $V = $ex->vd();

is($ex->plasma_concentration_at_time(0), 0,   'first dose - before: 0');
ok($ex->plasma_concentration_at_time(0.5) < 1000/$V,        'first dose - end: 0-1 clear /1');
ok($ex->plasma_concentration_at_time(0.5) > (1-$k)*1000/$V, 'first dose - end: 0-1 clear /2');
ok($ex->plasma_concentration_at_time(1.5) < (1-$k)*1000/$V, 'first dose - 1h later: 1-2 clear/1');
ok($ex->plasma_concentration_at_time(1.5) > (1-2*$k)*1000/$V, 'first dose - 1h later: 1-2 clear/2');

ok($ex->plasma_concentration_at_time(6) < 1000/$V, 'second - before: less than first dose');
ok($ex->plasma_concentration_at_time(7) < 2*1000/$V, 'second - end: less than total of both doses');
ok($ex->plasma_concentration_at_time(7) >   1000/$V, 'second - end: more than second dose');

ok($ex->plasma_concentration_at_time(12) < 1500/$V, 'third - before: less than second dose');
ok($ex->plasma_concentration_at_time(13) < 2500/$V, 'third - end: less than second and third dose');
ok($ex->plasma_concentration_at_time(13) > 1500/$V, 'third - end: more than third dose');

ok($ex->plasma_concentration_at_time(100) > 0, '100hrs: not 0');
ok($ex->plasma_concentration_at_time(100) < 0.02, '100hrs: less than 0.02');

is($ex->plasma_concentration_at_time(10000), 0, '10000hrs: 0');

done_testing();
