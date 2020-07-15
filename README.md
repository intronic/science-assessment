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

## Mike Pheasant: Thought Process

* First step was read the PDF
* Second step was thinking _easy i'll just read through the R code_ and I can use that for validation testing, so I downloaded that
    * _Hmm well that was some ugly R code_
        * formula as string, with parameter values (unsafely) concatenated in
        * string evaluated (unsafely) at run-time as an expression
        * some sort of eval/apply LISPy ideas but not what you'd want as a medical device
    * but the formulas are straight forward so I think I'll just dive in and do it...
* Next was chose the elimination process
    * linear seemed good enough
* Next was the route of administration
    * Infusion seemed most appropriate
* Next was review the formulae again (Section 1.2.1.2)
    * eq. 1.4 for single dose
    * eq. 1.5 for multiple
    * Thoughts here:
        * single dose is just a term for the _in-dose_ or _post-dose_ time steps
        * I added the _pre-dose_ 0 concentration case for ease & safety of coding also
        * multi dose is just a sum of all single doses that have been fully or partially dosed at time _t_ (given the assumptions anyway) (obvious in hindsight...)

* Next was implement the single dose step and put in some tests
    * see `t/10singledose.t` with some heuristics for reasonable conc. ranges
* Next was implement the multi-dose step and add tests
    * see `t/20multidose.t` with more heuristics
* Finally run the program and review the output file to verify the concentration goes up and down as roughly expected on the time points

My lasting impression was _wow, this just looks like a dive computer_ calculating blood nitrogen concentration in mulitple tissue compartments, increasing as you descend and decreasing as you ascend... with tunable parameters before the dive... hmmm a wearable device could be interesting twist to the DoseMe product line...
