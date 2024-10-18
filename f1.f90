!! f1.90: t_pdt defined in mo_pdt (fortran_support)

! MODULE - Contains parameterized derived tyoe t_pdt
MODULE mo_pdt
   IMPLICIT NONE

   TYPE t_pdt(k)
      INTEGER, KIND :: k
      REAL(k) :: val
   END TYPE t_pdt
END MODULE mo_pdt

! MODULE - Contains abstract type t_base
MODULE mo_base
   USE mo_pdt
   USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: real64
   IMPLICIT NONE

   TYPE, ABSTRACT :: t_base
      CONTAINS
         PROCEDURE(interface_func), DEFERRED :: func
   END TYPE t_base

   ABSTRACT INTERFACE
      SUBROUTINE interface_func(base, pdt)
         !IMPORT t_base, t_pdt, real64
         !! Workaround for gcc compiler
         USE mo_pdt, ONLY: t_pdt
         IMPORT t_base, real64

         CLASS(t_base) :: base
         TYPE(t_pdt(real64)) :: pdt
      END SUBROUTINE interface_func
   END INTERFACE
END MODULE mo_base

! MODULE - Contains type t_ext, extension of t_base
MODULE mo_ext
   USE mo_pdt
   USE mo_base
   USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: real64

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
END MODULE mo_ext

! MAIN
PROGRAM main
   USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: real64
   USE mo_pdt
   USE mo_ext
   IMPLICIT NONE

   TYPE(t_pdt(real64)) :: pdt_real64
   TYPE(t_ext) :: ext

   CALL ext%func(pdt_real64)
END PROGRAM main
