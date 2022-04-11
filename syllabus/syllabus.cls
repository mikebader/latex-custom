\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{syllabus}[2016/08/28 Manuscript Draft LaTeX class]

\ProcessOptions \relax
\LoadClassWithOptions{article}

%% LOAD REQUIRED PACKAGES
%\RequirePackage{natbib}
\RequirePackage{booktabs}
\RequirePackage[left=1.4in,right=1.2in,top=1in,bottom=1in]{geometry}
% \RequirePackage{hyperref}
\PassOptionsToPackage{hyphens}{url}
\RequirePackage{hyperref}
\RequirePackage[hyphens]{url}
\RequirePackage{natbib, bibentry}
\RequirePackage{ifthen}
\RequirePackage{titlesec}
\RequirePackage{tabularx}
\RequirePackage{xcolor}

% DEFINE GLOBAL VARIABLES 
\global\let\@office\@empty
\newcommand{\office}[1]{\def\@office{#1}}
\global\let\@coursenumber\@empty
\newcommand{\coursenumber}[1]{\def\@coursenumber{#1}}
\global\let\@term\@empty
\newcommand{\term}[1]{\def\@term{#1}}
\global\let\@classtime\@empty
\newcommand{\classtime}[1]{\def\@classtime{#1}}
\global\let\@classroom\@empty
\newcommand{\classroom}[1]{\def\@classroom{#1}}
\global\let\@coursetitle\@empty
\newcommand{\coursetitle}[1]{
	\def\@coursetitle{#1}
	\title{\@coursetitle}
	}
\global\let\@email\@empty
\newcommand{\email}[1]{\def\@email{\href{mailto:#1}{#1}}}
\global\let\@phone\@empty
\newcommand{\phone}[1]{\def\@phone{#1}}



%% MAKETITLE 
\renewcommand\@maketitle{
	\parindent 0pt
	\addtolength{\leftskip}{-.4in}
	\textbf{\@coursetitle}\\
	\textbf{\@coursenumber}
	\vspace{.25\baselineskip}

	\addtolength{\leftskip}{.4in}
	\begin{minipage}{.495\textwidth}
		\@term \\
		\@classtime \\
		\@classroom
	\end{minipage}
	\begin{minipage}{.5\textwidth}
		\raggedleft
		\@author \\
		\ifthenelse{\equal{\@email}{}}{}{\@email\\}
		\@office \\
	\end{minipage}
	\parindent 3em
}


%% PAGE FORMAT
\RequirePackage{fancyhdr}
\renewcommand{\footrulewidth}{.8pt}
\fancypagestyle{plain}{%
\fancyhf{}
\fancyfoot[R]{\small \bfseries \thepage}
\renewcommand{\headrulewidth}{0pt}
}

\fancypagestyle{fncy}{%
\fancyhf{}
\fancyhead[L]{\small \bfseries \@coursetitle}
\fancyhead[R]{\small \bfseries \@coursenumber}
\fancyfoot[R]{\small \bfseries \thepage}
\addtolength{\headheight}{2pt}
\renewcommand{\headrulewidth}{.8pt}
}
\fancyhfoffset[L]{.4in}
\fancyhfoffset[R]{1in}

\pagestyle{fncy}



%% FONTS AND TEXT APPEARANCE
\usepackage{tgheros}
\renewcommand{\labelitemi}{{\rmfamily \textbullet}} % Prevents problem with bullet in tgheros
\renewcommand{\familydefault}{\sfdefault} % Makes the default text sans serif

% Url appearance
\def\UrlFont{\bfseries}
\hypersetup{
    colorlinks = true,
	urlcolor = {red!50!black},
	citecolor = {blue!50!black}
}
\urlstyle{sf}

\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

%% HEADING FORMATS
\titleformat{\section}{\bfseries \scshape}{}{0px}{}{}
\titlespacing*{\section}{-.4in}{1.5\baselineskip}{0pt}
\titleformat{\subsection}{\sffamily \itshape}{}{0px}{}{\vspace{-2em}}
\titlespacing*{\subsection}{-.4in}{.5\baselineskip}{0pt}

%% NEW COUNTERS
\newcounter{week}
\newcounter{weekofunit}[subsection]

%% NEW ENVIRONMENTS
%% Objectives: define objectives for the class
\newenvironment{objectives}{\section{Objectives} \label{sec:objectives} By the end of this course students will be able to \begin{enumerate}\itemsep0em}{\end{enumerate}}

%% Outcomes: define outcomes for the class
\newenvironment{outcomes}{\section{Learning Outcomes}\label{sec:outcomes} Students will learn to \begin{itemize}\itemsep0em}{\end{itemize}}

%% Readings: define `reading` environment to include list of readings
\newenvironment{readings}{\par
	\noindent \textit{Readings:}\vspace{-.5\baselineskip}\begin{itemize}\parskip 3pt \itemsep0em
	}{
	\end{itemize}\vspace{-.5\baselineskip}
	}
\newenvironment{suggested}{\par
	\noindent \textit{Suggested:}\vspace{-.5\baselineskip}\begin{itemize}\parskip 3pt \itemsep0em
	}{
	\end{itemize}\vspace{-.5\baselineskip}
	}
%% NEW COMMANDS
%% week: Define how weekly entries appear in syllabus
\newcommand{\week}[2][]{
	% \ifthenelse{\NOT\equal{#1}{\baselineskip}}{\def\skip{#1} }{
		\ifthenelse{\equal{\theweekofunit}{0}}{\def\skip{0em}}{\def\skip{\baselineskip}}
		% }
	 \refstepcounter{week}\vspace{\skip}\noindent\textbf{Week~\theweek \ifthenelse{\equal{#1}{}}{}{~(#1)}: #2} 
	\refstepcounter{weekofunit}
	}

%% reading: Define rendering of a reading for class book
\newcommand{\reading}[3][]{\citeauthor[{#3}]{{#2}}\ifthenelse{\NOT\equal{#1}{}}{ \textit{#1}}{}}

%% syllabusnote: Write note in the right margin
\newcommand{\syllabusnote}[2][-.9\baselineskip]{\marginpar{\vspace{#1}\raggedright \small \textit{#2}}\normalsize}

%% class policies: Make way to load class policies from policies.txt file
\newcommand{\@policies}{}
\newcommand{\policy}[2]{%
     \g@addto@macro\@policies{\subsection{#1} \parbox{\dimexpr\linewidth-2\fboxsep}{#2}}
}
\newcommand{\showpolicies}{
\InputIfFileExists{policies}{}{}
\@policies
}

\newcommand{\showresources}{\input{resources}}

\global\let\@commonpartpath\@empty
\newcommand{\setcommonpartpath}[1]{\def\@commonpartpath{#1}}
\newcommand{\commonpartpath}{\@commonpartpath}

\newcommand{\gradepointtable}{
\InputIfFileExists{gradepointtable}{}{} 
}

\newcommand{\showgrades}{\input{grades}}


% BIBLIOGRAPHY
 \makeatletter 
 \renewcommand\BR@b@bibitem[2][]{\BR@bibitem[#1]{#2}\BR@c@bibitem{#2}}           
 \makeatother
\nobibliography*



\endinput