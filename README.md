# DoseMe Computational Science Assessment

## Get Started

1. Fork or clone this repository

2. Install dependencies

    ```bash
    cpanm --installdeps .
    ```

3. Run a script to generate a drug blood plasma concentration profile csv

    ```bash
    perl -Ilib scripts/concentration_profile.pl > concentration_plot.csv
    ```

## Guidelines

You will notice that the csv file the above script produces has zeroes in the concentration column. For this project, you will need to implement a method to calculate blood plasma concentration of a drug _Exampillin_. Look for TODO in source files and fill in the blanks.

A starting point cpanfile is provided. You do not need to use all of the included modules, and can add modules as needed.


## References

While the PFIM library is written for R and not perl, it provides a handy reference of pharmacokinetic terms, concept and formulae in Chapter 1

[Duboi, A, Bertrand, J, and Mentre, F. (2014) _PFIM 4.0 Library of Model._ PFIM Group. `http://www.pfim.biostat.fr/PFIM_PKPD_Library4.0.pdf`](http://www.pfim.biostat.fr/PFIM_PKPD_Library4.0.pdf)


## Mike Pheasant: Notes

* Any divers at DoseMe?
    * This looks like a dive computer...could turn product into a wearable device...

* Implemented:
    * Linear elimination
    * Single compartment
    * Multiple doses (infusion)
    * Equations 1.4 & 1.5, section 1.2.1.2 from PDF
