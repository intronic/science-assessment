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
            }, 1) > (1 - $k)*1000/$V, 'at end of infusion its less than one full clearance down 1/2');

ok($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 1000,
                tinf => 1
            }, 1) < 1000/$V, 'at end of infusion less than the whole dose is present 2/2');

ok($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 1000,
                tinf => 1
            }, 2) < (1 - $k)*1000/$V,  '1 hr after infusion stops its more than one cleareance down 1/2');

ok($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 1000,
                tinf => 1
            }, 2) > (1 - 2*$k)*1000/$V, '1 hr after infusion stops its not two cleareances down 2/2');

ok($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 1000,
                tinf => 1
            }, 100) < 0.01, 'after 100hr very low');

ok($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 1000,
                tinf => 1
            }, 1000) < 1e-30, 'after 1000hr very very low');

is($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 1000,
                tinf => 1
            }, 10000), 0, 'after 10000hr back to 0');

is($ex->plasma_concentration_single_dose_at_time({
                time => 0,
                k0 => 100000,
                tinf => 100
            }, 10000), 0, 'after 10000hr back to 0 big dose');

done_testing();
