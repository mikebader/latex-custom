\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{homework}[2016/09/05 Lecture Notes LaTeX class]
\ProcessOptions*\relax
\LoadClassWithOptions{exam}

%% The following removes the definitions of headers and footers from exam document class 
%% to allow use of fancyhdr package
\let\lhead\@undefined
\let\chead\@undefined
\let\rhead\@undefined
\let\lfoot\@undefined
\let\cfoot\@undefined
\let\rfoot\@undefined

%% Environment custommargins to change textwidth from:
%% http://www.latex-community.org/forum/viewtopic.php?f=5&t=878
\newenvironment{custommargins}[2]%
  {\addtolength{\leftskip}{#1}\addtolength{\rightskip}{#2}}{\par}

\let\saved@bibitem\@bibitem
\RequirePackage{bibentry}
\RequirePackage{amsmath}
\RequirePackage{booktabs}
\PassOptionsToPackage{hyphens}{url}\usepackage{hyperref}
\RequirePackage{natbib}
\RequirePackage{tikz}
\RequirePackage{pgfplots}
	\pgfplotsset{compat=1.12}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage[normalem]{ulem}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{calc}


%% DEFINE GLOBAL VARIABLES 
\global\let\@assignment\@empty
\newcommand{\assignment}[1]{\def\@assignment{#1}}
\global\let\@coursenumber\@empty
\newcommand{\coursenumber}[1]{\def\@coursenumber{#1}}
\global\let\@coursetitle\@empty
\newcommand{\coursetitle}[1]{\def\@coursetitle{#1}}
\global\let\@duedate\@empty
\newcommand{\duedate}[2][Due: ]{\def\@duedate{#1#2}}
\global\let\theauthor\@author

%% FONTS %%
\RequirePackage[math]{iwona}
\RequirePackage{tgheros}
\renewcommand{\labelitemi}{{\rmfamily \textbullet}} % Prevents problem with bullet in tgheros
\renewcommand{\familydefault}{\sfdefault} % Makes the default text sans serif

%% MAKETITLE
\renewcommand\@maketitle{
	\sffamily
	\begin{custommargins}{-.4in}{-.55in}
	{
		\bfseries \noindent \@title \hfill 
		\ifx\@duedate\@empty
		\else 
			\@duedate
		\fi
		\ifx\@assignment\@empty
		\else
			\\[0\baselineskip] \@assignment
		\fi
	} \\[0\baselineskip] \@coursetitle \\ \@coursenumber \\ \@author  
	\end{custommargins}\vspace{2em}
	}
\renewcommand\maketitle{\@maketitle \thispagestyle{plain}}

%% PAGE FORMAT
\RequirePackage{fancyhdr}
\renewcommand{\footrulewidth}{.8pt}
\fancypagestyle{plain}{%
\fancyhf{}
\fancyfoot[R]{\small \bfseries \thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{.8pt}
}

\fancypagestyle{fncy}{%
\fancyhf{}
\fancyhead[L]{\small \textbf{\@title}}
\fancyhead[R]{\small \textbf{\@coursenumber}}
\fancyfoot[R]{\small \bfseries \thepage}
\addtolength{\headheight}{2pt}
\renewcommand{\headrulewidth}{.8pt}
\renewcommand{\footrulewidth}{.8pt}
}
\fancyhfoffset[L]{.4in}
\fancyhfoffset[R]{.85in}

\pagestyle{fncy}

%% Url appearance
\def\UrlFont{\bfseries}
\hypersetup{
    colorlinks = true,
	urlcolor = {red!50!black},
	linkcolor = {red!50!black},
	citecolor = {blue!50!black},
	filecolor = {green!50!black}
}
\urlstyle{sf}

%% SOLUTION STYLING %%
\SolutionEmphasis{\small\itshape\color{black}}
\unframedsolutions

%% HEADING FORMATS
\titleformat{\section}{\bfseries \scshape}{}{0px}{}{}
\titlespacing*{\section}{-.4in}{1.5\baselineskip}{0pt}
\titleformat{\subsection}{\sffamily \itshape}{}{0px}{}{\vspace{-2em}}
\titlespacing*{\subsection}{-.4in}{.5\baselineskip}{0pt}

%% NEWCOMMANDS
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

\newcommand{\R}{\textsf{R}}

%% BIBLIOGRAPHY
 \renewcommand\BR@b@bibitem[2][]{\BR@bibitem[#1]{#2}\BR@c@bibitem{#2}}           


\endinput


