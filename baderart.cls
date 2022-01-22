% Customized manuscript class: baderart.cls
% changes the article class by updating formatting and adding features
% option "unpub" will place notice at top that manuscript is not published 

\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{baderart}[2014/10/30 Manuscript Draft LaTeX class]

%% Extends article class with new unpub option
\newif\ifunpub
\unpubfalse
\DeclareOption{unpub}{\unpubtrue}
\ProcessOptions*\relax
\LoadClassWithOptions{article}

%% REQUIRED PACKAGES
%% Page setup
\RequirePackage[top=1in,bottom=1in,left=1.7in,right=1.7in]{geometry}
\RequirePackage{titlesec} % For customizing section titles
                          % ( must be loaded before hyperref)


\RequirePackage[table]{xcolor}

%% Math packages
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{amsbsy}

%% Tables 
\RequirePackage{ctable}     % Custom caption formatting
\let\tnote\relax            % Prevents conflict with threeparttable
%% required packages for using huxtable-style tables from 
%% R package `huxtable`
\RequirePackage{array}
\RequirePackage{caption}
\RequirePackage{graphicx}
\RequirePackage{siunitx}
\RequirePackage[normalem]{ulem}
\RequirePackage{colortbl}
\RequirePackage{multirow}
\RequirePackage{hhline}
\RequirePackage{calc}
\RequirePackage{tabularx}
\RequirePackage{threeparttable}
\RequirePackage{wrapfig}
\RequirePackage{adjustbox}
\RequirePackage[%
  pdftex,%
  bookmarks=true,%
  breaklinks=true,%
  citebordercolor={1 1 1},  % Set all hyperlink borders to be invisible
  linkbordercolor={1 1 1},  %
  urlbordercolor={1 1 1}    %
  ]{hyperref}

%% Other table formatting
\RequirePackage{dcolumn}    % Align decimals
\RequirePackage{longtable}  % Multipage tables

%% Float formats
\RequirePackage{lscape}
\RequirePackage{rotating}

%% Layout
\RequirePackage{appendix}   % Elegant formatting of appendices
                            % Used, e.g., for supplements
\RequirePackage[%
  bottom,%
  hang,%
  flushmargin%
  ]{footmisc}                % Pretty footnotes
\RequirePackage{ragged2e}    % Better Justification
\RequirePackage{subcaption}  % For multi-part figures
\RequirePackage{setspace}    % Easily set line spacing
\RequirePackage{color, soul} % Highlighting
\RequirePackage{url}         % Pretty URLs

%% Allow comments
\RequirePackage{verbatim}    % Provides comment environment

%% Legacy packages
%% not sure if all are currently necessary
\RequirePackage[en-US]{datetime2} % Nice date printing
\RequirePackage{epstopdf}    % Convert EPS file to PDF
\RequirePackage{lastpage}    % Allows page x of y

%% FONTS
\RequirePackage{fourier}
\RequirePackage{roboto}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}

%% Set Roboto-Thin to be default sans serif font
\renewcommand{\sfdefault}{Roboto-TLF} 
\newcommand{\sftext}{\fontseries{el}\selectfont\sffamily}

%% BIBLIOGRAPHY
\RequirePackage{natbib}

%% DEFINE ABSTRACT ENVIRONMENT %%%%%
%% Keywords: creates \@keywords to be used in preamble to list keywords and
%%           then print those keywords below the abstract
\global\let\@keywords\@empty
\newif\ifkeywords
\keywordsfalse
\newcommand{\keywords}[1]{\def\@keywords{#1} \keywordstrue}

% \if@titlepage
%   \renewenvironment{abstract}{%
%       \titlepage
%       \null\vfil
%       \@beginparpenalty\@lowpenalty
%       \begin{center}%
%         \footnotesize
%         \bfseries \abstractname
%         \@endparpenalty\@M
%       \end{center}}%
%      {\par\vfil\null\endtitlepage}
% \else
  \renewenvironment{abstract}{%
    \begin{spacing}{1.2} %  Footnote spacing to improve legibility
    \if@twocolumn%
      \section*{\abstractname}%
    \else%
      \vspace{.5cm}
        \noindent\footnotesize\sffamily\textbf{\abstractname.}% Abstract title
        \fontseries{el}\selectfont% Set abstract font style to extra light
    \fi}%
    {\ifkeywords % Add keywords to bottom of abstract 
        \par\vspace{.20cm}%
        \noindent \textbf{Keywords.} % Keywords label
        \fontseries{el}\selectfont\@keywords % Set font to extralight and list 
                                             % keywords defined in \@ keywords 
                                             % macro 
    \fi
    \end{spacing}
    \pagebreak
    } % End renew abstract environment
% \fi


%% PUBLICATION STAUS NOTES
%% Defines series of commands to note different stages of publication and
%% place note at top of title page to indicate stage of publication

%% Draft: not submitted 
\DeclareRobustCommand{\draftnote}{
    \begin{spacing}{.85}\begin{flushleft}%
        \vspace{-3em} {\sftext DRAFT: Results and interpretations subject to change. Please contact the authors for the most recent version of the manuscript.}%
    \end{flushleft}\end{spacing}%
}

%% Under review: paper has been submitted or re-submitted for review
\DeclareRobustCommand{\underreview}{
    \begin{spacing}{.85}\begin{flushleft}%
        \vspace{-3em} {\sffamily NOTE: This is a draft manuscript that is currently under review. Please contact the authors for the most recent version of the manuscript.\\[1em]}%
    \end{flushleft}\end{spacing}%
}

%% Published: paper has been published (takes extra required argument for link
%%            to published version of the paper)
\DeclareRobustCommand{\published}[1]{
    \begin{spacing}{.85}\begin{flushleft}%
        \vspace{-3em} \textbf{\sffamily This paper has been published. Please see and cite the final version:}\\[\baselineskip]{\sffamily #1}%
    \end{flushleft}\end{spacing}%
}

%% Define which publication status note to use
\global\let\@unpubnote\@empty
\newcommand{\unpubnote}[1]{\def\@unpubnote{#1} \unpubtrue} 


%% PAGE STYLE
\RequirePackage{fancyhdr}
\global\let\@printdate\@empty
\newcommand{\printdate}[1]{\def\@printdate{#1}}
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


%% SECTION HEADING STYLES
%% Follows American Sociological Association styles

%% Section
\titleformat{\section}%
  {\normalfont\bfseries\MakeUppercase}%  Format as bold uppercase
  {\thesection}%                         Text of section label (empty)
  {0em}%                                 Horizontal sep bn label and text
  {}%                                    Code preceding section (empty)

\titlespacing*{\section}%
  {0em}  % Left margin
  {1em}  % Vertical space before title
  {0em}  % Vertical space after title
%\renewcommand*\section{\@startsection {section}{1}{\z@}%
%                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
%                                   {.1\p@  }%
%                                   {\normalfont\bfseries\MakeUppercase}}

\titleformat{\subsection}%
  {\normalfont\itshape}%  Format in italic
  {\thesubsection}%       Text of subsection label (empty)
  {0em}%                  Horizontal sep bn label and text
  {}%                     Code preceding text

\titlespacing*{\subsection}%
  {0em}  % Left margin
  {1em}  % Vertical space before title
  {0em}  % Vertical space after title

\setcounter{secnumdepth}{0}
\def\p@section{\thesection\,}

%% TITLE INFORMATION
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
  \endgroup
}%

%% TITLE LAYOUT
%% (Note that this does not use the built-in "titlepage")

%% Publication information
  %% Authors
  \global\let\@authorlist\@empty
  \newcommand{\authorlist}[1]{\def\@authorlist{#1}}

  %% Acknowledgements
  \global\let\@makeacknowledgments\@empty
  \DeclareRobustCommand{\acknowledgments}[1]{\def\@makeacknowledgments{#1}}

  %% Short title (used as header on subsequent pages)
  \global\let\@shorttitle\@empty
  \newcommand{\shorttitle}[1]{\def\@shorttitle{#1}}

  %% Subtitle
  \newif\ifsubtitle
  \subtitlefalse
  \global\let\@subtitle\@empty
  \newcommand{\subtitle}[1]{\def\@subtitle{#1} \subtitletrue}

%% Make title and authorship
\renewcommand\@maketitle{%
  \newpage
  \null % Zero-space first paragraph
  \ifunpub {%  Write publication status note if defined
    \noindent\sffamily\fontseries{el}\selectfont\@unpubnote%
  } \fi 
  \vskip 5cm%
  \begin{flushleft}%
  \let \footnote \thanks
    {%
      \raggedright\Large\textbf{\@title}\unskip\strut\par\vspace{.1cm}% Title
      \ifsubtitle% Subtitle (if defined)
        \raggedright\large\@subtitle\unskip\strut\par\vspace{.45cm}%
      \fi%
    }%
    \let\Oldarraystretch\arraystretch %
    \renewcommand{\arraystretch}{.5}  %

    % Table of author/affiliation
    \begin{tabular}[t]{l}\@author\end{tabular}%
    \par\vspace{1cm}%
    {\@date\unskip\strut\par}\vspace{-.25cm}%
  \end{flushleft}%
}

%% Make author and affiliation for coauthors
\let\Oldtabcolsep\tabcolsep
\setlength{\tabcolsep}{0pt}
\def\and{% 
  \\[1em] \end{tabular}%
  \renewcommand{\arraystretch}{.5}
  \hskip 1em \@plus.17fil%
  \begin{tabular}[t]{l}}
\setlength{\tabcolsep}{\Oldtabcolsep}


%% DEFINE CAPTION STYLES
\captionsetup{labelfont={sf,bf},textfont={sf},labelsep=period}
\captionsetup[subfigure]{labelfont={sf}}
\renewcommand{\thesubfigure}{\alph{subfigure}}


%% DEFINE COLUMN TYPES 
%% use `tabularx` custom formatting tools
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\hspace{0pt}\arraybackslash}b{#1}}
\newcolumntype{L}[1]{>{\RaggedRight\hspace{0pt}\arraybackslash}p{#1}}
% \newcolumntype{S}[1]{>{@}l}

%% DEFINE NEW COMMANDS 
%% Redefine margin note spacing to be single-spaced and script-size 
\let\Oldmarginpar\marginpar
\DeclareRobustCommand{\marginpar}[1]{\Oldmarginpar{\scriptsize\singlespace #1}}

%% Define expectation operator
\RequirePackage{bm}
\DeclareRobustCommand{\Ex}{\mathop{\bf E\/}}

%% Define command R to be printed as sans serif (for referencing R program)
\newcommand{\R}{\textsf{R}}

%% Add command "strong" to mimic "textbf" (helps to match with html)
\DeclareRobustCommand{\strong}[1]{\textbf{#1}}

%% Insert text to say "Table|Figure about here" as required by some journals
%% Two required arguments
%%    #1 Name (e.g., "Figure" or "Table")
%%    #2 Label (e.g., "fig:thisfig"); will automatically insert table number
%%         but the tables must appear *in order* later in the document
\DeclareRobustCommand{\abouthere}[2]{%
  \begin{center}[Insert #1 \ref{#2} about here]\end{center}%
}

%% Highlighting
%% Defines two helpful commands:
%%    \TK:       Needs more information (with optional argument to insert
%%               what needs to be added)
%%    \needcite: Notes that a citation is needed (with optional argument to 
%%               insert names of citations to enter)
%% I wrote about this at: https://mikebader.net/blog/entries/2020/07/31/keeping-flow/
\DeclareRobustCommand{\highlight}[1]{\colorbox{yellow}{#1}}
\DeclareRobustCommand{\needsinfo}[2][]{\strong{\hl{[#2}\ifthenelse{\equal{#1}{}}{}{\hl{: #1}}\hl{]}}}
\DeclareRobustCommand{\needcite}[1][]{\needsinfo[#1]{CITE}}
\DeclareRobustCommand{\TK}[1][]{\needsinfo[#1]{TK}}





\DeclareRobustCommand{\myaffiliation}{American University}
\DeclareRobustCommand{\me}{Michael~D.\ M.\ Bader}
\DeclareRobustCommand{\mycorrespondence}{Correspondence: Michael D.~M.~Bader, Department of Sociology, American University, 4400 Massachusetts Ave., NW, Watkins G-13, Washington, DC, 20016; bader@american.edu.  }
\DeclareRobustCommand{\myauthorinfo}{\me \\ \myaffiliation}



% Not sure that I need the following:
\DeclareRobustCommand{\correction}[1]{\textbf{\color{red} #1}} %% Correction


\endinput