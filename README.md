This repo contains:

* Script for generating x86-64 assembler routines performing arithmetics on multi-limb integers,
along with the boilerplate necessary to use it from C and C++.
The focus is on simplicity, correctness and resistance to timing attacks.

* C++ code for in-field arithmetics.

# TODO

* Somewhat optimize assembly multiplication routines, if it’s worth the trouble. Specifically, store
some intermediate results in the registers instead of adding them to the result in memory
immediately. Also, support for `mulx` (BMI2) and `adcx`/`adox` (ADX) would be nice to have.
See: https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/ia-large-integer-arithmetic-paper.pdf

* Implement a more efficient method of modular inversion; for example, implement algorithms from the
following papers:
 - [New Algorithm for Classical Modular Inverse](https://link.springer.com/content/pdf/10.1007%2F3-540-36400-5_6.pdf)
 - [Montgomery inversion](https://cetinkoc.net/docs/j82.pdf)
 - [The Montgomery Modular Inverse - Revisited](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.75.8377&rep=rep1&type=pdf)
