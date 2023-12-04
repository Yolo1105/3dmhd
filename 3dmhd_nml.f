
C#define IUNDEF_VAL -2147483647

C     $Id: linend.F 72 2013-12-06 14:04:06Z wangsl $

      integer function linend(cline)
      implicit real*8(a-h,o-z)
c
c     function which returns the length of a character string,
c     excluding trailing blanks, tabs and nulls.
c
      character*(*) cline, blank
      character*1 null, tab
      parameter (blank=' ')
c
      null = char(0)
      tab = char(9)
      do 5 i = len(cline), 1, -1
          if(cline(i:i).ne.blank.and.
     $    cline(i:i).ne.null.and.
     $    cline(i:i).ne.tab) goto 10
    5     continue
      linend = 0
      return
   10 linend = i
      return
      end

      SubRoutine SetupFromNameListFile(IPar, Par, FInp, FOut)
      INCLUDE '3dmhdparam.f'
C      Implicit None
c Integer IPar(32)
c Real*8 Par(64)
c Character*50 FInp, FOut

      Character*512 NameListFile
      Logical LOK
      Integer IOK
      Integer LinEnd
      External LinEnd
      Integer I, IFin

      NameList /MyParameters/ IPar, Par, FInp, FOut

C      Write(6, NML=MyParameters)

      Call GetEnv('MY_NAMELIST_FILE', NameListFile)
      If(LinEnd(NameListFile) .eq. 0) NameListFile = '3dmhd.nml'
      LOK = .False.
      Inquire(File=NameListFile, Exist=LOK)
      If(.not. LOK) return 

      IFin = 98
      Open(Unit=IFin, File=NameListFile, Status='Old')
      IOK = -1000
      Read(IFin, NML=MyParameters, IOStat=IOK)
      Close(IFin)
C      If(IOK .eq. 0) 
C     $  Write(6, *) 'Read namelist succesfully'

C      Write(6, NML=MyParameters)

      End

#if 0
      Program Main
        Implicit None
        Integer IPar(32)
        Character*50 FInp, FOut
        Integer IUndef
        Parameter(IUndef=IUNDEF_VAL)
        Integer I
        Data(IPar(I), I=1,32)/32*IUndef/
        Data FInp/''/, FOut/''/

        Call MyTest(IPar, FInp, FOut)
      End
#endif
