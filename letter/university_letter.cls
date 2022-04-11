% Customized letter class:  university_letter.cls
% changes the letter class by adding letterhead
% option either "sign" (default) or "nosign"; the sign feature includes your signature
% which must be in a file signature.jpg

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{university_letter}

\RequirePackage{ifthen}

\newboolean{@sign}
\newboolean{@policy}

% Defaults:  signed, sociology
\setboolean{@sign}{true}
\DeclareOption{sign}{
	\setboolean{@sign}{true}}
\DeclareOption{nosign}{
	\setboolean{@sign}{false}}

\setboolean{@policy}{false}
\DeclareOption{policy}{
  \setboolean{@policy}{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}

\ProcessOptions
\LoadClass{letter}


%\RequirePackage{times}
\RequirePackage{graphicx}
\RequirePackage{url}
\RequirePackage{fontspec}
\RequirePackage{xunicode}
\RequirePackage{xcolor}
\RequirePackage[hmargin=1.75in]{geometry}
\RequirePackage{hyperref}


% set JHU brand guidelines
\definecolor{JHUblue}{HTML}{002D72}

\hypersetup {
  colorlinks = true,
  allcolors = JHUblue
}

\newcommand{\dept}{Department of 
  \ifthenelse{\boolean{@policy}}{Public Administration \& Policy}{Sociology}
  }


\def\myauthor{Michael Bader}
\def\mytitle{Associate Professor of Sociology}
\def\mycopyright{\myauthor}
\def\mybibliostyle{plain}
\def\mysubtitle{}
\def\myaffiliation{Johns Hopkins University}
\def\myphone{}
\def\myfax{}
\def\myemail{mbader@jhu.edu}
\def\myversion{}
\def\myrevision{}
\def\myaddress{Mergenthaler Hall 540, 3400 N. Charles Street, Baltimore, MD 21218}


\setlength{\topmargin}{-1.5cm}
\setlength{\footskip}{1.5cm}
\newsavebox{\tsheader}
\newsavebox{\universitylogo}

\sbox{\universitylogo}{\parbox{0.75\paperwidth}{
     \includegraphics[scale=0.55]{krieger.logo.horizontal.blue.pdf} \\[-2.3em]
        {\color{JHUblue}\hrule}
        \raggedleft{\raisebox{-.75em}{\color{JHUblue}\scriptsize\scshape\dept}}

}}
		
\sbox{\tsheader}{\parbox[b]{\paperwidth}{
  \centering\usebox{\universitylogo}\raisebox{0cm}}}

% create box for footer
\newsavebox{\deptaddress}
\sbox{\deptaddress}{\parbox{\paperwidth}{
  \centering\color{JHUblue}\scriptsize\scshape \myaddress}}


\newcounter{figure}
\renewcommand \thefigure {\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}
\renewcommand\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\newcommand\figurename{Figure}
\newcommand\tablename{Table}

\renewcommand{\ps@firstpage}{%
  \setlength{\headheight}{0cm}\setlength{\headsep}{3.5cm}%
  \renewcommand{\@oddhead}{\hspace{-1.75in}\usebox{\tsheader}}
  \renewcommand{\@oddfoot}{\hspace{-1.75in}\usebox{\deptaddress}}%
  \renewcommand{\@evenhead}{}
  % \renewcommand{\@evenfoot}{\hspace{-1.5in}\usebox{\deptaddress}}%
  }

\providecommand{\@evenhead}{} 
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{} 
\providecommand{\@oddfoot}{}

\renewcommand{\closing}[1]{
  \hspace*{4cm}
	\parbox{\textwidth}{
	\ifthenelse{\equal{#1}{}}{}{#1\\}
	\ifthenelse{\boolean{@sign}}{\includegraphics[height=4em]{signature.jpg}\\}{\bigskip \bigskip \bigskip \bigskip \bigskip \ifthenelse{\equal{#1}{}}{}{{ }\\}}	
	\raggedright \fromsig}}

\signature{Michael D.~M.~Bader\\Associate Professor of Sociology\\\url{mbader@jhu.edu}}
	
