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

Returns: Concentration using linear elimination with single compartment and infusion with multiple doses

(eq 1.5) From 1.2.1.2: One Compartment/Multiple Dose/Infusion

  * Amounts to: additive accumulation of multiple single doses at time t

- Multiple doses: at time t after n doses D_i (i = 1, ...n) given at time t_D_i (t ≥ t_D_n )
- For infusion, the duration of infusion is Tinf for single dose and Tinf_i (i = 1, ...n) for multiple doses.
- D is the total administered dose for single dose; D_i is the total i th administered dose for multiple doses.

- Doesnt check: For multiple doses, the delay between successive doses is supposed to be constant and to be greater than
infusion duration (t_D_i+1 − t_D_i = constant and t_D_i+1 − t_D_i > Tinf_i for infusion).

=cut
sub plasma_concentration_at_time {
    my ($self, $t) = @_;
    my $doses = $self->doses;

    my $conc = 0;
    foreach my $dose (@{$doses}) {
        my $c = $self->plasma_concentration_single_dose_at_time($dose, $t);
        $conc += $c;
        # print("t=$t [$dose->{time} $dose->{k0} $dose->{tinf}]   $c  $conc  \n");
    }

    return $conc;
}


=head2 BUILDARGS

Builds Drug object

=cut
around BUILDARGS => sub {
    my ( $orig, $class, %args ) = @_;

    return { doses => $args{doses} };
};


1;
