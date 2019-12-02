# SIFT-Flow
SIFT Flow: Dense Correspondence across Scenes and its Applications. Liu et. al. IEEE transactions on pattern analysis and machine intelligence 33, no. 5 (2010): 978-994.
https://people.csail.mit.edu/celiu/SIFTflow/

## installation
follow the **readme.txt** instruction in each folder.

## modification to original code
* Fixed ** error: cannot convert ‘int*’ to ‘const mwSize* ** error while compiling mex (replace int with mwSize in several files). And fixed file name typo in Matrix.h line 5.
* Generated dense sift with 128 bin into bin file using `generate_SIFT.m`
* Generated sift flow bin file using `generate_SIFTflow.m`

## Note
* No personal contributions.
* Tested on Ubuntu 16.04, MATLAB R2019b.
