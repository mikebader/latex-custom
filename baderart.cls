\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{baderart}[2014/10/30 Manuscript Draft LaTeX class]
\newif\ifunpub
\unpubfalse
\DeclareOption{unpub}{\unpubtrue}
\ProcessOptions*\relax
\LoadClassWithOptions{article}

\RequirePackage[table]{xcolor}
\RequirePackage[top=1in,bottom=1in,left=1.7in,right=1.7in]{geometry}

\RequirePackage{appendix}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{amsbsy}
\RequirePackage{bm}
\RequirePackage{array}
\RequirePackage{caption}
\RequirePackage{ctable}
\RequirePackage{datetime}
\RequirePackage{dcolumn}
\RequirePackage{epstopdf}
\RequirePackage{fancyhdr}
\RequirePackage[bottom,hang,flushmargin]{footmisc}
\RequirePackage{graphicx}
\RequirePackage{lastpage}
\RequirePackage{longtable}
\RequirePackage{lscape}
\RequirePackage{ragged2e}
\RequirePackage{rotating}
\RequirePackage{setspace}
\RequirePackage{color, soul}
\RequirePackage{subcaption}
%\RequirePackage[lofdepth,lotdepth]{subfig}
%\RequirePackage{textcase}
\RequirePackage{titlesec}
\RequirePackage{url}
\RequirePackage{verbatim}


%% FONTS
% \RequirePackage[thin]{roboto}
\RequirePackage{fourier}
\usepackage{roboto}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\renewcommand{\sfdefault}{Roboto-TLF}
% \renewcommand{\sfdefault}{\sfdefault{el}}
% \newcommand*{\robotothin}{\fontfamily}
\newcommand{\sftext}{\fontseries{el}\selectfont\sffamily}

%% BIB
\RequirePackage{natbib}
\RequirePackage[pdftex,bookmarks=true,breaklinks=true,citebordercolor={1 1 1},linkbordercolor={1 1 1}, urlbordercolor={1 1 1}]{hyperref}

%%%%% DEFINE ABSTRACT ENVIRONMENT %%%%%
\if@titlepage
  \renewenvironment{abstract}{%
	  \titlepage
	  \null\vfil
	  \@beginparpenalty\@lowpenalty
	  \begin{center}%
		\footnotesize
		\bfseries \abstractname
		\@endparpenalty\@M
	  \end{center}}%
	 {\par\vfil\null\endtitlepage}
\else
\renewenvironment{abstract}{\if@twocolumn%
								\section*{\abstractname}%
							\else
						\vspace{.5cm}\begin{spacing}{1.2}\noindent\footnotesize\sffamily\textbf{\abstractname.}\fontseries{el}\selectfont
							\fi}%
							{\ifkeywords\if@twocolumn\else\par\vspace{.20cm}\noindent \textbf{Keywords.} \fontseries{el}\selectfont\@keywords \fi\fi \end{spacing}\pagebreak}
%	  \fi}
%	  {\if@twocolumn\else \\[2em] \noindent \textbf{Keywords.} \@keywords \fi \pagebreak}
\fi

%%%%% PARAGRAPH SETTINGS %%%%%
%\parindent 3em
%\parskip 1em

%%%%% DEFINE COLUMN TYPES %%%%%
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\hspace{0pt}\arraybackslash}b{#1}}
\newcolumntype{L}[1]{>{\RaggedRight\hspace{0pt}\arraybackslash}p{#1}}
\newcolumntype{S}[1]{>{@}l}

%%%%% DEFINE NEW COMMANDS %%%%%
\let\Oldmarginpar\marginpar
\DeclareRobustCommand{\marginpar}[1]{\Oldmarginpar{\scriptsize\singlespace #1}}
\DeclareRobustCommand{\Ex}{\mathop{\bf E\/}}
\DeclareRobustCommand{\abouthere}[2]{\begin{center}[Insert #1 \ref{#2} about here]\end{center}}
\DeclareRobustCommand{\correction}[1]{\textbf{\color{red} #1}}
\DeclareRobustCommand{\strong}[1]{\textbf{#1}}
\DeclareRobustCommand{\highlight}[1]{\colorbox{yellow}{#1}}
\DeclareRobustCommand{\needsinfo}[2][]{\strong{\hl{[#2}\ifthenelse{\equal{#1}{}}{}{\hl{: #1}}\hl{]}}}
\DeclareRobustCommand{\needcite}[1][]{\needsinfo[#1]{CITE}}
\DeclareRobustCommand{\TK}[1][]{\needsinfo[#1]{TK}}

% \DeclareRobustCommand{\needcite}[1][]{\strong{\hl{[CITE}\ifthenelse{\equal{#1}{}}{}{\hl{: #1}}\hl{]}}}
\DeclareRobustCommand{\draftnote}{
	\begin{spacing}{.85}\begin{flushleft}%
		\vspace{-3em} {\sftext DRAFT: Results and interpretations subject to change. Please contact the authors for the most recent version of the manuscript.}%
	\end{flushleft}\end{spacing}%
}
\DeclareRobustCommand{\underreview}{
	\begin{spacing}{.85}\begin{flushleft}%
		\vspace{-3em} {\sffamily NOTE: This is a draft manuscript that is currently under review. Please contact the authors for the most recent version of the manuscript.\\[1em]}%
	\end{flushleft}\end{spacing}%
}
\DeclareRobustCommand{\published}[1]{
	\begin{spacing}{.85}\begin{flushleft}%
		\vspace{-3em} \textbf{\sffamily This paper has been published. Please see and cite the final version:}\\[\baselineskip]{\sffamily #1}%
	\end{flushleft}\end{spacing}%
}

\global\let\@unpubnote\@empty
\newcommand{\unpubnote}[1]{\def\@unpubnote{#1} \unpubtrue}
\global\let\@keywords\@empty
\newif\ifkeywords
\keywordsfalse
\newcommand{\keywords}[1]{\def\@keywords{#1} \keywordstrue}
\global\let\@makeacknowledgments\@empty
\DeclareRobustCommand{\acknowledgments}[1]{\def\@makeacknowledgments{#1}}
\global\let\@shorttitle\@empty
\newcommand{\shorttitle}[1]{\def\@shorttitle{#1}}
\global\let\@authorlist\@empty
\newcommand{\authorlist}[1]{\def\@authorlist{#1}}
\global\let\@journal\@empty
\newcommand{\journal}[1]{\def\@journal{#1}}
\global\let\@printdate\@empty
\newcommand{\printdate}[1]{\def\@printdate{#1}}
\newif\ifsubtitle
\subtitlefalse
\global\let\@subtitle\@empty
\newcommand{\subtitle}[1]{\def\@subtitle{#1} \subtitletrue}


\DeclareRobustCommand{\myaffiliation}{American University}
\DeclareRobustCommand{\me}{Michael~D.\ M.\ Bader}
\DeclareRobustCommand{\mycorrespondence}{Correspondence: Michael D.~M.~Bader, Department of Sociology, American University, 4400 Massachusetts Ave., NW, Watkins G-13, Washington, DC, 20016; bader@american.edu.  }
\DeclareRobustCommand{\myauthorinfo}{\me \\ \myaffiliation}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhfoffset{.5in}
\headheight 15pt
\pdfpagewidth 8.5in
\pdfpageheight 11in
\lhead{\sftext\MakeUppercase{\@shorttitle}}
\chead{}
\rhead{\sftext\MakeUppercase{\@authorlist~\thepage}}
\lfoot{}
\cfoot{}
\rfoot{\sftext\@printdate}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\headrulewidth}{0pt}

\titleformat{\section}
  {\normalfont\bfseries\MakeUppercase}{\thesection}{0em}{}
\titlespacing*{\section}
  {0em}{1em}{0em}
%\renewcommand*\section{\@startsection {section}{1}{\z@}%
%                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
%                                   {.1\p@  }%
%                                   {\normalfont\bfseries\MakeUppercase}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {.1\p@  }%
                                     {\normalfont\itshape}}
\setcounter{secnumdepth}{0}
\def\p@section{\thesection\,}

\let\Oldtabcolsep\tabcolsep
\setlength{\tabcolsep}{0pt}
\renewcommand\maketitle{\begingroup%
\renewcommand\thefootnote{\@fnsymbol\c@footnote}%
\def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 0em\noindent
            \hb@xt@0em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}\sffamily\fontseries{el}\selectfont##1}%
   \if@twocolumn
     \ifnum \col@number=\@ne
       \@maketitle
     \else
       \twocolumn[\@maketitle]%
     \fi
   \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
%    \fi
    \thispagestyle{empty}\hspace{-.8cm}\@thanks
%  \setcounter{footnote}{0}%
%  \global\let\thanks\relax
%  \global\let\maketitle\relax
%  \global\let\@maketitle\relax
%  \global\let\@thanks\@empty
%  \global\let\@author\@empty
%  \global\let\@date\@empty
%  \global\let\@title\@empty
%  \global\let\title\relax
%  \global\let\author\relax
%  \global\let\date\relax
%  \global\let\and\relax
  \endgroup
}%

\renewcommand\@maketitle{%
  \newpage
  \null
  % \ifunpub {\sffamily\@unpubnote} \fi 
  \ifunpub {\noindent\sffamily\fontseries{el}\selectfont\@unpubnote} \fi 
  \vskip 5cm%
  \begin{flushleft}%
  \let \footnote \thanks
	{\raggedright\Large\textbf{\@title}\unskip\strut\par\vspace{.1cm}%
    \ifsubtitle\raggedright\large\@subtitle\unskip\strut\par%
    \vspace{.45cm} \fi }%
	\let\Oldarraystretch\arraystretch%
	\renewcommand{\arraystretch}{.5}%
	\begin{tabular}[t]{l}\@author\end{tabular}\par\vspace{0cm}%
	{\@date\unskip\strut\par}\vspace{-.25cm}%    {\LARGE \@title \par}%
  \end{flushleft}%
	}

\def\and{% 
  \\[1em] \end{tabular}%
  \renewcommand{\arraystretch}{.5}
  \hskip 1em \@plus.17fil%
  \begin{tabular}[t]{l}}
\setlength{\tabcolsep}{\Oldtabcolsep}




\captionsetup{labelfont={sf,bf},textfont={sf},labelsep=period}
\captionsetup[subfigure]{labelfont={sf}}
\renewcommand{\thesubfigure}{\alph{subfigure}}


\newcommand{\R}{\textsf{R}}






\endinput