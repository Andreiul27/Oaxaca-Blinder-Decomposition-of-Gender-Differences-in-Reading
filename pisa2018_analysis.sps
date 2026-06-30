* ============================================================
* PISA 2018 Reading Achievement Analysis — SPSS Syntax
* ============================================================
* Combines all SPSS sections (Appendix B.1-B.7, B.9, B.10).
* Several sections call IEA IDB Analyzer (v5.0.5) macros.
*
* BEFORE RUNNING:
* 1. Update PROJECT_DIR below to your local project folder
*    (containing PISA_2018.sav / PISA2018 - Copy.sav).
* 2. Update MACRO_DIR to your local IDB Analyzer install path
*    (default location shown below; varies by Windows username).
* 3. Find-and-replace these placeholders throughout the file
*    if your SPSS version does not support macro variables for
*    file paths in INCLUDE / infile statements.
*
* Example values used during development:
*   PROJECT_DIR = C:\Users\<your-username>\Desktop\PISA THESIS
*   MACRO_DIR   = C:\Users\<your-username>\AppData\Roaming\IEA\IDBAnalyzerV5\bin\Data\Templates\SPSS_Macros
* ============================================================


* ------------------------------------------------------------
* B.1 Computation of the New Indices "SCIR," "READJOYFREQ," and "PDIR"
* ------------------------------------------------------------
* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
COMPUTE SCIR=MEAN(ST161Q01HA, ST161Q02HA, ST161Q03HA).
EXECUTE.

WEIGHT BY W_FSTUWT.

DESCRIPTIVES VARIABLES=SCIR
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

RECODE ST175Q01IA (1=0) (2=1) (3=2) (4=3) (5=4) (SYSMIS=SYSMIS).
EXECUTE.

COMPUTE READJOYFREQ=MEAN(ST175Q01IA).
EXECUTE.

WEIGHT BY W_FSTUWT.

DESCRIPTIVES VARIABLES=READJOYFREQ
/SAVE
/STATISTICS=MEAN STDDEV MIN MAX.

RECODE ST161Q06HA (4=1) (3=2) (2=3) (1=4) (SYSMIS=SYSMIS) INTO ST161Q06R.
EXECUTE.

      RECODE ST161Q07HA (4=1) (3=2) (2=3) (1=4) (SYSMIS=SYSMIS) INTO ST161Q07R.
      EXECUTE.

     RECODE ST161Q08HA (4=1) (3=2) (2=3) (1=4) (SYSMIS=SYSMIS) INTO ST161Q08R.
     EXECUTE.

COMPUTE PDIR=MEAN(ST161Q06R, ST161Q07R, ST161Q08R).
EXECUTE.

WEIGHT BY W_FSTUWT.

DESCRIPTIVES VARIABLES=PDIR
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.


* ------------------------------------------------------------
* B.2 Associations Among the Variables
* ------------------------------------------------------------
* Encoding: UTF-8.
* Script created using the IEA IDB Analyzer (Version 5.0.5).
* Created on 2/23/2022 at 12:52 AM.
* Press Ctrl+A followed by Ctrl+R to submit this analysis.
include file = "<MACRO_DIR>\JB_Cor.ieasps".
JB_Cor infile="<PROJECT_DIR>\PISA_2018.sav"/
	 cvar=CNTRYID /
	 xvar=JOYREAD STIMREAD WORKMAST SCIR PDIR READJOYFREQ /
	 wgt=W_FSTUWT/
	 rwgt=W_FSTURWT/
	 kfac=0.5/
	 jk2type=/
	 stratvar=/
	 nrwgt=80/
	 nomiss=Y/
	 strctry = N/
	 method=BRR/
	 pairwise=Y/
	 viewcod=N/
	 ndec=2/
	 clean = Y/
	 selcrit = /
	 selvar = /
	 intavg = Y/
	 outdir="<PROJECT_DIR>"/
	 outfile="CORRELATIONPAIRWISE".


* ------------------------------------------------------------
* B.3 Associations Between Student's Attributes and the Reading Achievement
* ------------------------------------------------------------
* Script created using the IEA IDB Analyzer (Version 5.0.5).
* Created on 3/15/2022 at 8:47 PM.
* Press Ctrl+A followed by Ctrl+R to submit this analysis.
include file = "<MACRO_DIR>\JB_CorP.ieasps".
JB_CorP 	 infile="<PROJECT_DIR>\PISA_2018.sav"/
	 cvar=CNTRYID /
	 xvar0=JOYREAD PDIR SCIR READJOYFREQ STIMREAD WORKMAST /
	 PVRoots=PV /
	 PVTails=READ /
	 npv=10/
	 wgt=W_FSTUWT/
	 nrwgt=80 /
	 rwgt=W_FSTURWT/
	 jkz=/
	 jkr=/
	 jk2type=/
	 stratvar=/
	 nomiss=Y/
	 strctry = N/
	 method=BRR/
	 pairwise=N/
	 kfac=0.5/
	 shrtcut=N/
	 viewcod=N/
	 ndec=2/
	 clean = Y/
	 selcrit = /
	 selvar = /
	 intavg = Y/
	 outdir="<PROJECT_DIR>"/
	 outfile="PVANDCORR".


* ------------------------------------------------------------
* B.4 Reading Achievement Average Based on Gender
* ------------------------------------------------------------
* Encoding: windows-1252.
* Script created using the IEA IDB Analyzer (Version 5.0.5).
* Created on 2/23/2022 at 1:23 AM.
* Press Ctrl+A followed by Ctrl+R to submit this analysis.

include file = "<MACRO_DIR>\JB_PV.ieasps".

JB_PV 	 infile="<PROJECT_DIR>\PISA_2018.sav"/
	 cvar=CNTRYID ST004D01T /
	 almvars=/
	 rootpv=PV /
	 tailpv=READ /
	 npv=10/
	 wgt=W_FSTUWT/
	 nrwgt=80 /
	 rwgt=W_FSTURWT/
	 jkz=/
	 jkr=/
	 jk2type=/
	 stratvar=/
	 nomiss=Y/
	 method=BRR/
	 kfac=0.5/
	 shrtcut=N/
	 viewcod=N/
	 ndec=2/
	 clean = Y/
	 strctry = N/
	 intavg = Y/
	 graphs=Y/
	 selcrit = /
	 selvar = /
	 outdir="<PROJECT_DIR>"/
	 outfile="meanreadingacchivbygender".


* ------------------------------------------------------------
* B.5 The Analysis of the Mean Difference
* ------------------------------------------------------------
* Encoding: windows-1252.
* Script created using the IEA IDB Analyzer (Version 5.0.5).
* Created on 3/4/2022 at 7:25 PM.
* Press Ctrl+A followed by Ctrl+R to submit this analysis.

include file = "<MACRO_DIR>\JB_Gen.ieasps".

JB_gen 	 infile="<PROJECT_DIR>\PISA_2018.sav"/
	 cvar=CNTRYID ST004D01T /
	 almvars=/
	 xvar=JOYREAD STIMREAD WORKMAST SCIR PDIR READJOYFREQ /
	 wgt=W_FSTUWT/
	 rwgt=W_FSTURWT/
	 kfac=0.5/
	 jk2type=/
	 stratvar=/
	 nrwgt=80/
	 nomiss=Y/
	 method=BRR/
	 viewcod=N/
	 ndec=2/
	 clean = Y/
	 strctry = N/
	 intavg = Y/
	 graphs=Y/
	 selcrit = /
	 selvar = /
	 outdir="<PROJECT_DIR>"/
	 outfile="MeanDifferenceAnalysis".


* ------------------------------------------------------------
* B.6 Analysis of Pooled Regressions Using Gender as a Dummy Variable
* ------------------------------------------------------------
* Encoding: UTF-8.
* Script created using the IEA IDB Analyzer (Version 5.0.5).
* Created on 2/23/2022 at 1:51 AM.
* Press Ctrl+A followed by Ctrl+R to submit this analysis.

include file = "<MACRO_DIR>\JB_RegGP.ieasps".

JB_RegGP 	 infile="<PROJECT_DIR>\PISA_2018.sav"/
	 cvar=CNTRYID /
	 convar=JOYREAD STIMREAD WORKMAST SCIR PDIR READJOYFREQ  /
	 catvar=ST004D01T /
	 codings=D/
	 refcats=1/
	 ncats=2/
	 PVRoots=/
	 PVTails=/
	 dvar0=/
	 rootpv=PV /
	 tailpv=READ /
	 npv=10/
	 wgt=W_FSTUWT/
	 nrwgt=80 /
	 rwgt=W_FSTURWT/
	 jkz=/
	 jkr=/
	 jk2type=/
	 stratvar=/
	 nomiss=Y/
	 method=BRR/
	 missing=listwise/
	 kfac=0.5/
	 shrtcut=N/
	 viewcod=N/
	 ndec=2/
	 clean = Y/
	 strctry = N/
	 viewprgs=Y/
	 viewlbl=Y/
	 qcstats=Y/
	 newout=Y/
	 intavg = Y/
	 selcrit = /
	 selvar = /
	 outdir="<PROJECT_DIR>"/
	 outfile="PRGenderDummyVariable".


* ------------------------------------------------------------
* B.7 Gender-Specific Regression Models
* ------------------------------------------------------------
* Encoding: UTF-8.
* Script created using the IEA IDB Analyzer (Version 5.0.5).
* Created on 2/23/2022 at 1:51 AM.
* Press Ctrl+A followed by Ctrl+R to submit this analysis.
include file = "<MACRO_DIR>\JB_RegGP.ieasps".
JB_RegGP 	 infile="<PROJECT_DIR>\PISA_2018.sav"/
	 cvar=CNTRYID ST004D01T /
	 convar=JOYREAD STIMREAD WORKMAST SCIR PDIR READJOYFREQ /
	 catvar=/
	 codings=D/
	 refcats=1/
	 ncats=2/
	 PVRoots=/
	 PVTails=/
	 dvar0=/
	 rootpv=PV /
	 tailpv=READ /
	 npv=10/
	 wgt=W_FSTUWT/
	 nrwgt=80 /
	 rwgt=W_FSTURWT/
	 jkz=/
	 jkr=/
	 jk2type=/
	 stratvar=/
	 nomiss=Y/
	 method=BRR/
	 missing=pairwise/
	 kfac=0.5/
	 shrtcut=N/
	 viewcod=N/
	 ndec=2/
	 clean = Y/
	 strctry = N/
	 viewprgs=Y/
	 viewlbl=Y/
	 qcstats=Y/
	 newout=Y/
	 intavg = Y/
	 selcrit = /
	 selvar = /
	 outdir="<PROJECT_DIR>"/
	 outfile="SEPARATEBYGENDER".


* ------------------------------------------------------------
* B.9 Collinearity Checks
* ------------------------------------------------------------
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT PV1READ
  /METHOD=ENTER JOYREAD STIMREAD WORKMAST SCIR PDIR READJOYFREQ.


* ------------------------------------------------------------
* B.10 Inter-Item Correlation Matrix
* ------------------------------------------------------------
RELIABILITY
  /VARIABLES=ST161Q01HA ST161Q02HA ST161Q03HA ST161Q06R ST161Q07R ST161Q08R
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=CORR.
