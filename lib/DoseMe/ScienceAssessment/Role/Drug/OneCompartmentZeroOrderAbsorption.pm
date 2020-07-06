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

Non-saturable kinetics assumed.

=cut
sub plasma_concentration_single_dose_at_time {
    my ($self, $dose, $t) = @_;

    # TODO:

    return 0; # TODO
}

1;
