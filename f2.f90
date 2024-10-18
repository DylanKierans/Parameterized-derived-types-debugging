!! f2.f90: t_pdt defined in mo_base (communication_types)

! MODULE - Contains pdt type t_pdt, abstract type t_base, and extension t_ext
MODULE mo_pdt_base_ext
   USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: real64
   IMPLICIT NONE

   TYPE t_pdt(k)
      INTEGER, KIND :: k
      REAL(k) :: val
   END TYPE t_pdt

   TYPE, ABSTRACT :: t_base
      CONTAINS
         PROCEDURE(interface_func), DEFERRED :: func
   END TYPE t_base

   ABSTRACT INTERFACE
      SUBROUTINE interface_func(base, pdt)
         IMPORT t_base, t_pdt, real64
         ! Workaround not available for gcc compiler since t_pdt is defined in same file

         CLASS(t_base) :: base
         TYPE(t_pdt(real64)) :: pdt
      END SUBROUTINE interface_func
   END INTERFACE

   TYPE, EXTENDS(t_base) :: t_ext
      CONTAINS 
         PROCEDURE :: func => func
   END TYPE t_ext

   CONTAINS
      SUBROUTINE func(base, pdt)
         CLASS(t_ext) :: base
         TYPE(t_pdt(real64)) :: pdt

         PRINT *, "pdt%k = ", pdt%k
         PRINT *, "pdt%val = ", pdt%val
      END SUBROUTINE func
END MODULE mo_pdt_base_ext

! MAIN
PROGRAM main
   USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: real64
   USE mo_pdt_base_ext ! Now provides t_pdt, t_base, t_ext
   IMPLICIT NONE

   TYPE(t_pdt(real64)) :: pdt_real64
   TYPE(t_ext) :: ext

   CALL ext%func(pdt_real64)
END PROGRAM main
