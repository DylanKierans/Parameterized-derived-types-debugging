NAG_FC	= /sw/spack-levante/nag-7.1-lqjbej/bin/nagfor
NV22_FC	= /sw/spack-levante/nvhpc-22.5-v4oky3/Linux_x86_64/22.5/compilers/bin/nvfortran
#NV24_FC  = /sw/spack-levante/nvhpc-24.5-ipi3ad/Linux_x86_64/24.5/compilers/bin/nvfortran
NV24_FC 	= /sw/spack-levante/nvhpc-24.9-p7iohv/Linux_x86_64/24.9/compilers/bin/nvfortran
I_FC 		= /sw/spack-levante/intel-oneapi-compilers-2022.0.1-an2cbq/compiler/latest/linux/bin/intel64/ifort
G_FC 		= /sw/spack-levante/gcc-11.2.0-bcn7mb/bin/gfortran
SRC ?= f1.f90

all: nag nv22 nv24 intel gcc

nag: ${SRC}
	$(NAG_FC) $< -o ${SRC:%.f90=%_$@.exe} &> /dev/null && echo "[SUCCESS] $@" || echo "[FAIL] $@"

nv22: ${SRC}
	$(NV22_FC) $< -o ${SRC:%.f90=%_$@.exe} &> /dev/null && echo "[SUCCESS] $@" || echo "[FAIL] $@"

nv24: ${SRC}
	$(NV24_FC) $< -o ${SRC:%.f90=%_$@.exe} &> /dev/null && echo "[SUCCESS] $@" || echo "[FAIL] $@"

intel: ${SRC}
	$(I_FC) $< -o ${SRC:%.f90=%_$@.exe} &> /dev/null && echo "[SUCCESS] $@" || echo "[FAIL] $@"

gcc: ${SRC}
	$(G_FC) $< -o ${SRC:%.f90=%_$@.exe} &> /dev/null && echo "[SUCCESS] $@" || echo "[FAIL] $@"

clean: 
	${RM} *.mod *.exe

.PHONY: clean all
