#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use DoseMe::ScienceAssessment::Exampillin;
use DoseMe::ScienceAssessment::Role::Drug::OneCompartmentZeroOrderAbsorption;

my $ex = DoseMe::ScienceAssessment::Exampillin->new();


is($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 2000,
                tinf => 0.5
            }, -1), 0, '0 before dose');

is($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 1000,
                tinf => 1
            }, 0), 0, 'immediately at dose');

my $k = $ex->cl() / $ex->vd();
my $V = $ex->vd();
ok($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 1000,
                tinf => 1
            }, 1) < 1000/$V, 'at end of infusion almost the whole dose is present');
ok($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 1000,
                tinf => 1
            }, 1) > (1 - $k)*1000/$V, 'at end of infusion it is not fully cleared');


done_testing();
