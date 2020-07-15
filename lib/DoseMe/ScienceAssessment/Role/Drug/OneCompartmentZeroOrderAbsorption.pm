use utf8;
use v5.30.0;
use strictures 2;

package DoseMe::ScienceAssessment::Role::Drug::OneCompartmentZeroOrderAbsorption;

use Exporter 'import';

use Moo::Role;
with 'DoseMe::ScienceAssessment::Role::Drug';

our @EXPORT_OK = qw( plasma_concentration_single_dose_at_time );

=head2 plasma_concentration_single_dose_at_time

Calculate blood plasma concentration of drug after a single dose given at time t.

Inputs:

* dose - hashref - a hashref describing a dose (i.e. time of administration, infusion rate, infusion length)
* t - numeric - time of administration in hours

Returns: Concentration using linear elimination

(eq 1.4) From 1.2.1.2: One Compartment/Single Dose/Infusion

       D      1
C(t) = ____ . __ . (1 - e^ −k(t − t_D)   | if t - t_D <= Tinf
       Tinf   k.V

       D      1
     = ____ . __ . (1 - e^ -k.Tinf) . e^ −k(t − t_D - Tinf)   | if t - t_D > Tinf
       Tinf   k.V

     = 0                   | if t < tD

     and D / Tinf = Dose Rate = dose k0

Non-saturable kinetics assumed.

=cut

sub plasma_concentration_single_dose_at_time {
    my ($self, $dose, $t) = @_;

    my $k = $self->cl() / $self->vd();  # Elimination rate
    my $V = $self->vd();
    my $k0 = $dose->{'k0'};
    my $t_D = $dose->{'time'};
    my $Tinf = $dose->{'tinf'};

    return $t < $t_D ? 0 :
            $t - $t_D < $Tinf ?
            (1 - exp(-$k * ($t - $t_D))) * $k0 / ($k * $V)
            : (1 - exp(-$k * $Tinf)) * exp(-$k * ($t - $t_D - $Tinf)) * $k0 / ($k * $V);
}


1;
