# Parameterized Derived Types

## Description 

This repo is a minimal example to show `nvfortran` compiler issue with when dealing with Parameterized Derived Types (pdt) when using abstract types. A minimal working example reduced from ICON codebase.

The program contains:
* Type (`t_pdt`) - parameterized derived type with a kind parameter
* Type (`t_base`) - Abstract type with deferred function `func`, which takes parameter `t_pdt` with `kind=real64`
* Type (`t_ext`) - Non-abstract, concretized type extension of `t_base` which defines `func`

Two files are given:

* `f1.90`: Intended code structure
  * `t_pdt` defined in `mo_pdt`
  * `t_base` defined in `mo_base`
  * `t_ext` defined in `mo_ext`
* `f2.90`: Incompatible code structure, used purely for debugging
  * `t_pdt` defined in `mo_pdt_base_ext`
  * `t_base` defined in `mo_pdt_base_ext`
  * `t_ext` defined in `mo_pdt_base_ext`

## Testing

Testing on Levante with compilers:
* `nvhpc@22.5`
* `nvhpc@24.9`
* `gcc@11.2.0`
* `intel@2021.5.0`
* `nag@7.1.1`

Usage:
* `make SRC=f1.f90` 
* `make SRC=f2.f90`

## Output

Compilation (y/n):

|       | nvhpv@22.5 | nvhpc@24.9 | gcc@11.2.0 | intel@2021.5.0 | nag@7.1.1 |
|-------|------------|------------|------------|----------------|-----------|
| f1.90 | n          | n          | y*          | y              | y         |
| f2.90 | y          | y          | n          | y              | y         |


