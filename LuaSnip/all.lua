local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    -- Basic Document Structure
    s(
        "doc",
        fmt(
            [[
  \documentclass{{article}}
  \usepackage{{amsmath, amssymb, graphicx, parskip}}
  \title{{}}
  \author{{Ryan Liu}}

  \newtheorem{{theorem}}{{Theorem}}[section]
  \newtheorem{{claim}}{{Claim}}[section]
  \newtheorem{{subclaim}}{{Subclaim}}[claim]
  \newtheorem{{corollary}}{{Corollary}}[theorem]
  \newtheorem{{lemma}}[theorem]{{Lemma}}

  \renewcommand{{\thesubsection}}{{\thesection.\alph{{subsection}}}}


  \begin{{document}}
  \maketitle
  \thispagestyle{{empty}}
  \newpage
  \pagenumbering{{arabic}}

  {}

  \end{{document}}
  ]],
            { i(1, "Your content here") }
        )
    ),

    -- Begin-End Environment
    s(
        "env",
        fmt(
            [[
  \begin{{{}}}
    {}
  \end{{{}}}
  ]],
            { i(1, "environment"), i(2, "content"), i(1) }
        )
    ),

    -- Equation
    s(
        "eq",
        fmt(
            [[
  \begin{{equation}}
    {}
  \end{{equation}}
  ]],
            { i(1, "e=mc^2") }
        )
    ),

    -- Align Equations
    s(
        "align",
        fmt(
            [[
  \begin{{align*}}
    {} &= {} \\
    {} &= {}
  \end{{align*}}
  ]],
            { i(1, "a"), i(2, "b"), i(3, "c"), i(4, "d") }
        )
    ),

    -- Itemized List
    s(
        "item",
        fmt(
            [[
  \begin{{itemize}}
    \item {}
    \item {}
  \end{{itemize}}
  ]],
            { i(1, "First item"), i(2, "Second item") }
        )
    ),

    -- Enumerated List
    s(
        "enum",
        fmt(
            [[
  \begin{{enumerate}}
    \item {}
    \item {}
  \end{{enumerate}}
  ]],
            { i(1, "First item"), i(2, "Second item") }
        )
    ),

    -- Figure
    s(
        "fig",
        fmt(
            [[
  \begin{{figure}}[h]
    \centering
    \includegraphics[width=0.8\textwidth]{{{}}}
    \caption{{{}}}
    \label{{fig:{}}}
  \end{{figure}}
  ]],
            { i(1, "image.png"), i(2, "Caption"), i(3, "label") }
        )
    ),

    -- Table
    s(
        "table",
        fmt(
            [[
  \begin{{table}}[h]
    \centering
    \begin{{tabular}}{{|c|c|c|}}
      \hline
      {} & {} & {} \\
      \hline
      {} & {} & {} \\
      \hline
    \end{{tabular}}
    \caption{{{}}}
    \label{{table:{}}}
  \end{{table}}
  ]],
            {
                i(1, "Col1"),
                i(2, "Col2"),
                i(3, "Col3"),
                i(4, "Data1"),
                i(5, "Data2"),
                i(6, "Data3"),
                i(7, "Caption"),
                i(8, "label"),
            }
        )
    ),

    -- Inline Math
    s(
        "math",
        fmt(
            [[
  ${}$
  ]],
            { i(1, "x^2 + y^2 = z^2") }
        )
    ),

    -- Bold and Italic
    s("bf", fmt("\\textbf{{{}}}", { i(1, "bold text") })),
    s("it", fmt("\\textit{{{}}}", { i(1, "italic text") })),

    -- Sections
    s("sec", fmt("\\section{{{}}}", { i(1, "Section Title") })),
    s("subsec", fmt("\\subsection{{{}}}", { i(1, "Subsection Title") })),
    s("subsubsec", fmt("\\subsubsection{{{}}}", { i(1, "Subsubsection Title") })),

    -- References and Labels
    s("ref", fmt("\\ref{{{}}}", { i(1, "label") })),
    s("label", fmt("\\label{{{}}}", { i(1, "label") })),
    s("cite", fmt("\\cite{{{}}}", { i(1, "citation_key") })),
}
