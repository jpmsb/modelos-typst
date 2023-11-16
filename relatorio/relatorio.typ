#let ifsc-logo = {
    let quadradoVerde = rect(radius: 1pt, fill: rgb("32a041"), width: 15pt, height: 15pt)
    let quadradoBranco = rect(radius: 1pt, fill: white, width: 15pt, height: 15pt)
    let circulo = circle(fill: rgb("c8191e"), radius: 7.5pt)

    set text(font: "Carlito")
    
    grid(
        columns: (auto),
        rows: 5,
        gutter: 0.5pt,
        
        align(center)[
            #grid(
                columns: 3,
                rows: 2,
                gutter: 3pt,

                circulo,
                quadradoVerde,
                quadradoVerde,
                quadradoVerde,
                quadradoVerde,
                quadradoBranco,
                quadradoVerde,
                quadradoVerde,
                quadradoVerde,
                quadradoVerde,
                quadradoVerde,
                quadradoBranco
            )
            #text(weight: "bold", 22pt)[INSTITUTO \ FEDERAL \ ]
            #text(18pt)[Santa Catarina]
            #line(length: 50%, stroke: 1pt + rgb("32a041"))
            #text(18pt)[Câmpus \ São José]
        ]
    )
}

#let capa(titulo, subtitulo, curso, disciplina, professor, alunos, data) = {
  set text(lang: "pt")
  set text(font: "Carlito")
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2cm),
  )

  align(center + top)[
    // #image("imagens/ifsc-v.png", height: 22.2%)
    #ifsc-logo
  ]

  grid(rows: 100pt)
  
  align(center)[
    #line(length: 100%, stroke: 1pt)
    #text(24pt)[*#titulo*] \
    #text(12pt)[#subtitulo]
    #line(length: 100%, stroke: 2pt)
  ]

  grid(rows: 18pt)
  
  table(
    columns: (auto, auto),
    stroke: none,
    align: horizon,
    [#text(12pt)[*Curso:*]], [#curso],
    [#text(12pt)[*Disciplina:*]], [#disciplina],
    [#text(12pt)[*Professor:*]], [#professor]
  )

  grid(rows: 50pt)

  align(right)[
    #if alunos.len() > 1 [
      #text(12pt, weight: "bold")[Alunos]; \
    ] else [
      #text(12pt, weight: "bold")[Aluno]; \
    ]
    
    #for nome in alunos {
      text(11pt)[#nome \ ];
    }
  ]

  align(center + bottom)[
    #data;
  ]

}

#let imagem(arquivo, largura, titulo, autor) = {
  set text(lang: "pt")
  set text(font: "Carlito")
  align(center)[
    #grid(
      columns: (auto),
      rows: 3,
      rect(width: largura, fill: luma(240), stroke: 1pt)[#titulo],
      rect(width: largura)[#image(arquivo, width: largura)],
      rect(width: largura, fill: luma(240), stroke: 1pt)[#autor]
    )
  ]
}

#let imagemb(arquivo, largura, titulo, autor) = {
  set text(lang: "pt")
  set text(font: "Carlito")
  align(center)[
    #grid(
      columns: (auto),
      rows: 3,
      rect(
        width: largura,
        fill: luma(240),
        stroke: 1pt,
        radius: (top-left: 20%, top-right: 20%)
      )[#titulo],

      rect(width: largura)[#image(arquivo, width: largura)],

      rect(
        width: largura,
        fill: luma(240),
        stroke: 1pt,
        radius: (bottom-left: 20%, bottom-right: 20%)
      )[#autor]
    )
  ]
}

#let imagemc(arquivo, largura, titulo, autor) = {
  set text(lang: "pt")
  set text(font: "Carlito")
  align(center)[
    #grid(
      columns: (auto),
      rows: 3,
      rect(
        width: largura,
        fill: luma(240),
        stroke: (top: black + 1pt, left: black + 1pt, right: black + 1pt),
        radius: (top-left: 20%, top-right: 20%)
      )[#titulo],

      rect(
        width: largura,
        stroke: (left: black + 1pt, right: black + 1pt)
      )[#image(arquivo, width: largura)],

      rect(
        width: largura,
        fill: luma(240),
        stroke: (bottom: black + 1pt, left: black + 1pt, right: black + 1pt),
        radius: (bottom-left: 20%, bottom-right: 20%)
      )[#autor]
    )
  ]
}

#let codigo(
    caption: none,             // content of caption bubble (string, none)
    bgcolor: rgb("#f6f8fa"),   // back ground color (color)
    strokecolor: 1pt + rgb("#173f4f"), // frame color (color)
    hlcolor: auto,             // color to use for highlighted lines (auto, color)
    width: 100%,
    radius: 3pt,
    inset: 5pt,
    numbers: false,            // show line numbers (boolean)
    stepnumber: 1,             // only number lines divisible by stepnumber (integer)
    numberfirstline: false,    // if the firstline isn't divisible by stepnumber, force it to be numbered anyway (boolean)
    numberstyle: auto,         // style function to apply to line numbers (auto, style)
    firstnumber: 1,            // number of the first line (integer)
    highlight: none,           // line numbers to highlight (none, array of integer)
    content
) = {
    if type(hlcolor) == "auto" {
        hlcolor = bgcolor.darken(10%)
    }
    if type(highlight) == "none" {
        highlight = ()
    }
    block(
        width: width,
        fill: bgcolor,
        stroke: strokecolor,
        radius: radius,
        inset: inset,
        clip: false,
        {
            // Draw the caption bubble if a caption was set
            if caption != none {
                style(styles => {
                    let caption_block = block(width: width,
                            inset: inset,
                            radius: radius,
                            fill: bgcolor,
                            stroke: strokecolor,
                            caption)
                    place(
                        top + left,
                        dx: 0em,
                        dy: -(measure(caption_block, styles).height/20),
                        caption_block 
                    )
                })
                // skip some vertical space to avoid the caption overlapping with
                // the beginning of the content
                v(.6em)
            }

            let (columns, align, make_row) = {
                if numbers {
                    // line numbering requested
                    if type(numberstyle) == "auto" {
                        numberstyle = text.with(style: "italic", 
                                        slashed-zero: true, 
                                        size: .6em
                                      )
                    }
                    ( ( auto, 1fr ),
                      ( right + horizon, left ),
                      e => {
                        let (i, l) = e
                        let n = i + firstnumber
                        let n_str = if (calc.rem(n, stepnumber) == 0) or (numberfirstline and i == 0) { numberstyle(str(n)) } else { none }
                        (n_str + h(.5em), raw(lang: content.lang, l))
                      }
                    )
               } else {
                    ( ( 1fr, ),
                      ( left, ),
                      e => {
                        let (i, l) = e
                        raw( lang:content.lang, l)
                      }
                    )
                }
            }
            table(
                stroke:none,
                columns: columns,
                rows: (auto,),
                gutter: 0pt,
                inset: 2pt,
                align: (col, _) => align.at(col),
                fill: (c, row) => if (row / 2 + firstnumber) in highlight { hlcolor } else { none },
                ..content
                    .text
                    .split("\n")
                    .enumerate()
                    .map(make_row)
                    .flatten()
                    .map(c => if c.has("text") and c.text == "" { v(1em) } else { c })
            )
        }
    )
}
