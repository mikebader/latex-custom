\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{lecturenotes}[2016/09/05 Lecture Notes LaTeX class]
\ProcessOptions*\relax
\LoadClassWithOptions{article}


%% Environment custommargins to change textwidth from:
%% http://www.latex-community.org/forum/viewtopic.php?f=5&t=878
\newenvironment{custommargins}[2]%
  {\addtolength{\leftskip}{#1}\addtolength{\rightskip}{#2}}{\par}

%% LOAD REQUIRED PACKAGES
\RequirePackage[utf8]{inputenc}
\RequirePackage{amsmath}
\RequirePackage{booktabs}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage[left=1.2in,right=2in,top=1in,bottom=1in, marginparwidth=1.2in]{geometry}
\RequirePackage{hyperref}
\RequirePackage{ifthen}
\RequirePackage{lastpage}
\RequirePackage[fulladjust]{marginnote}
\RequirePackage{pstricks}
\RequirePackage{tikz}
	\usetikzlibrary{arrows.meta}
\RequirePackage{titlesec}
\RequirePackage{titling}


%% DEFINE GLOBAL VARIABLES
\gdef\default@weeklabel{Week}
\global\let\@weeklabel\default@weeklabel
\newcommand{\weeklabel}[1]{\def\@weeklabel{#1}}
\gdef\default@lessonlabel{Lesson}
\global\let\@lessonlabel\default@lessonlabel
\newcommand{\lessonlabel}[1]{\def\@lessonlabel{#1}}
\global\let\@week\@empty
\newcommand{\week}[1]{\def\@week{#1}}
\global\let\@lesson\@empty
\newcommand{\lesson}[1]{\def\@lesson{#1}}
\global\let\@coursenumber\@empty
\newcommand{\coursenumber}[1]{\def\@coursenumber{#1}}
\global\let\@coursetitle\@empty
\newcommand{\coursetitle}[1]{\def\@coursetitle{#1}}
\gdef\default@timeunits{minutes}
\global\let\@timeunits\default@timeunits
\newcommand{\timeunits}[1]{\def\@timeunits{#1}}
\global\let\theauthor\@author


\def\hrulefill{\leavevmode\leaders\hrule height .4pt\hfill\kern\z@}

%% Time
\newif\if@addminutes
\def\addminutes{\global\@addminutestrue}
\@addminutesfalse
%\DeclareOption{addminutes}{\addminutes}
\newif\if@minuteschanged
\@minuteschangedfalse

\newcount\minutes
\newcount\totalminutes
\newcount\sectionminutes


%% Fonts %%
\usepackage{tgheros}
\renewcommand{\labelitemi}{{\rmfamily \textbullet}} % Prevents problem with bullet in tgheros
\renewcommand{\familydefault}{\sfdefault} % Makes the default text sans serif

%% Url appearance
\def\UrlFont{\bfseries}
\hypersetup{
    colorlinks = true,
	urlcolor = {red!50!black},
	citecolor = {blue!50!black}
}
\urlstyle{sf}

%% Document Title %%
\renewcommand\@maketitle{
\sffamily
\begin{custommargins}{-.4in}{-1in}
{\bfseries \@title \hfill  \@weeklabel\ \@week, \@lessonlabel\ \@lesson} \\[0\baselineskip] \@coursetitle \\ \@coursenumber \\ \@author  
\end{custommargins} 
}

%% Page Style (fancyhdr) %%
\renewcommand{\footrulewidth}{.8pt}
\fancypagestyle{plain}{%
\fancyhf{}
\fancyfoot[C]{\small \sffamily Page \thepage\ of\ \pageref{LastPage}}
\renewcommand{\headrulewidth}{0pt}
}

\fancypagestyle{following}{%
\fancyhf{}
\fancyhead[L]{\small \sffamily \theauthor}
\fancyhead[C]{\small \sffamily \@coursetitle}
\fancyhead[R]{\small \sffamily \@week, \@lesson}
\fancyfoot[C]{\small \sffamily Page \thepage\ of\ \pageref{LastPage}}
\addtolength{\headheight}{2pt}
\renewcommand{\headrulewidth}{.8pt}
}
\fancyhfoffset[L]{.4in}
\fancyhfoffset[R]{1in}
\pagestyle{following}


%% Section Heading Styles (titlesec, lastpage) %%
\newcommand{\classsection}[2]{\section*{#1\marginpar{\sffamily \bfseries #2 minutes}}}
\titleformat{\section}{\sffamily \bfseries \scshape \large}{}{0px}{}{}
\titlespacing{\section}{-.4in}{1.5\baselineskip}{-\baselineskip}

\newcommand{\classtopic}[2]{\subsection*{#1\marginpar{\sffamily \itshape #2 minutes}}}
\titleformat{\subsection}{\sffamily \itshape}{}{0px}{}{\vspace{-2em}}
\titlespacing{\subsection}{-.4in}{0px}{-\baselineskip}


%% Objectives Environments %%
\newenvironment{lessonobjectives}{\textbf{Objectives for Lesson}  \begin{itemize}}{\end{itemize}\vspace{.5\baselineskip}}
\newenvironment{courseobjectives}{\textbf{Course Objectives}\begin{itemize}}{\end{itemize}}

\newenvironment{objectives}[2]{%
\vspace{.25\baselineskip} \sffamily \parskip 0pt \begin{custommargins}{-.4in}{-1in} \hrulefill \\
\begin{lessonobjectives}#1\end{lessonobjectives}\begin{courseobjectives}#2\end{courseobjectives}%
}{%
\vspace{-.5\baselineskip}\hrulefill  \end{custommargins} \vspace{-1\baselineskip}%
}

%% Other new commands %%
\newcommand{\concept}[2]{\parbox{\textwidth}{\raggedright \textbf{Concept: #1\\\emph{#2}}}}
\newcommand{\response}[1]{\par\vspace{-1\baselineskip}\begin{custommargins}{3em}{0em}$\longrightarrow$ #1\end{custommargins}}
\newcommand{\code}[1]{\texttt{#1}}

\newcommand{\reset@minutes}{\minutes\z@}
\newcommand{\recordsectionminutes}[2]{
	\immediate\write\@mainaux {\string\gdef\string\minutes@\romannumeral#1 {#2}}\reset@minutes%
	}
\newcommand{\writesectionminutes}[2]{%
	\def\thistest{\csname minutes@\romannumeral#1 \endcsname}
	\sectionminutes#2
	\ifcsname minutes@\romannumeral#1 \endcsname \advance\sectionminutes by \thistest \typeout{\the\sectionminutes}\else
  \ClassWarningNoLine{lecturenotes}{Section minutes might not have beed added correctly; I suggest re-running.}\fi
%	\ifstrequal{\thistest}{}{\typeout{NOPE}}{\typeout{YUP: \thistest}}
%	\advance\sectionminutes by \thistest}
	\the\sectionminutes
	}


\let\oldsection\section
\renewcommand{\section}[2][0]{%
	\recordsectionminutes{\thesection}{\the\minutes}%
	\oldsection{#2}%
	\marginpar{\vspace{0em}\raggedleft \sffamily \bfseries \writesectionminutes{\thesection}{#1} \@timeunits}%
	\advance\totalminutes by #1%
	}
%\ifstrequal{#1}{}{}{\marginpar{\vspace{0em}\raggedleft \sffamily \bfseries #1 \timeunits}}}

\let\oldsubsection\subsection
\renewcommand{\subsection}[2][]{\oldsubsection{#2}\ifstrequal{#1}{}{}{\marginpar{\vspace{0em}\raggedleft \sffamily \itshape #1 \@timeunits}  \advance\minutes by #1 \advance\totalminutes by #1}}

\newcommand{\sidenote}[1]{\hspace{0pt}\marginpar{\itshape \raggedleft #1}}
\newcommand{\slide}[0]{\sidenote{Slide}}
\newcommand{\demo}[0]{\sidenote{Demo}}

% \newcommand{\code}[1]{\texttt{#1}}

%\@startsection {section}{1}{\z@}%
                                   % {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   % {-1em}%
                                   % {\normalfont\Large\bfseries}}

%% Spacing
\parindent 0px
\parskip \baselineskip
\setlength\itemsep{-.5em}
\setlist[itemize]{noitemsep, topsep=0pt}
\setlist[description]{topsep=0pt}
\setlist[enumerate]{noitemsep, topsep=0pt}

\AtEndDocument{\recordsectionminutes{\thesection}{\the\minutes}}
