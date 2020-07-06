#!/usr/bin/perl

use utf8;
use v5.30.0;
use strictures 2;

package DoseMe::ScienceAssessment::Role::Drug;

use Exporter 'import';

use Moo::Role;

requires 'vd';
requires 'cl';
requires 'plasma_concentration_single_dose_at_time';

our @EXPORT = qw( plasma_concentration_at_time );

=head2 doses

an arrayref of hashrefs of dose description

each hashref conains:
* time - time in hours when this dose is admnistered
* k0   - infusion rate, in mg/hour
* tinf - length of infusion, in hours

=cut
has doses => (
    is => 'ro'
);


=head2 plasma_concentration_at_time

Calculate blood plasma concentration of drug at time t

Inputs:

* t - numeric - time of administration in hours

=cut
sub plasma_concentration_at_time {
    my ($self, $t) = @_;
    my $doses = $self->doses;

    # TODO:

    return 0; # TODO
}


=head2 BUILDARGS

Builds Drug object

=cut
around BUILDARGS => sub {
    my ( $orig, $class, %args ) = @_;

    return { doses => $args{doses} };
};


1;
