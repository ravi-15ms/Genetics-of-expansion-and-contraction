# Genetics-of-expansion-and-contraction
Scripts, SINS simulation tool, and input files used in https://www.biorxiv.org/content/10.1101/2024.03.28.586951v1


## Scripts
1. **ms_code_final.ipynb**: Code related to panmictic population: effect of contraction speed on genetic diversity at the end of contraction + validation using msprime simulations + code to reproduce Figure 5 

#### File associated with ms_code_final.ipynb
G_0.5_5_2_18x13_K100_m2_40ind_SW.csv : Genetic diversity (mean number of alleles and expected heterozygosity) data generated from SINS simulation.

2. **Allometric_plots.R**: Code related to Figure 4A (main text), Figure S6 (Supp Mat).
#### File associated with Allometric_plots.R in Data_allometry
a) damuth1987.xlsx: Population Desnity and Body Mass (Data from Damuth, John. "Interspecific allometry of population density in mammals and other animals: the independence of body mass and population energy-use." Biological Journal of the Linnean Society 31.3 (1987): 193-246)

b) DD_BM_2013_santini.csv: Dispersal Distance and Body Mass (Data from Santini, Luca, et al. "Ecological correlates of dispersal distance in terrestrial mammals." Hystrix: The Italian Journal of Mammalogy 24.2 (2013))

c) GLmammals.xlsx: Generation length and Body Mass (Data from Pacifici, Michela, et al. "Generation length for mammals." Nature Conservation 5 (2013): 89-94.)

## SINS Simulation tool
The SINS program can be found here: https://github.com/PopConGen/SINS

### Input files for SINS
Input files for SINS are in the **input_SINS.zip** folder.

### Quick guide to running SINS and analyzing its output
For a detailed step-by-step tutorial on generating SINS output and analyzing the results, refer to **SINS-QuickGuide.pdf**. This document covers practical aspects, including:

- How to install and run SINS on your system.
- How to set up input files.
- How to interpret and analyze the output data.

