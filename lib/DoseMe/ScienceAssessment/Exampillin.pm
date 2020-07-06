use utf8;
use v5.30.0;
use strictures 2;

package DoseMe::ScienceAssessment::Exampillin;

use Moo;
with 'DoseMe::ScienceAssessment::Role::Drug::OneCompartmentZeroOrderAbsorption';

# volume of distribution of Exampillin
sub vd {
    return 68.6;
}

# clearance of Exampillin
sub cl {
    return 6.03;
}

1;
