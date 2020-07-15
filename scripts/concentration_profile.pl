#!/usr/bin/env perl

use DoseMe::ScienceAssessment::Exampillin;

# create an Exampillin drug object and add some doses

my $exampilin_model = DoseMe::ScienceAssessment::Exampillin->new(
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

# produce concentration profile of exampillin over 24 hours
# sampling every 5 minutes

print "time,concentration\n";

# * over 48 hours
for(my $time = 0; $time <= 48; $time += 5/60) {
    my $concentration = $exampilin_model->plasma_concentration_at_time($time);
    print "$time,$concentration\n";
}
