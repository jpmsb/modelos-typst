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
            ),
            #text(weight: "bold", 22pt)[INSTITUTO \ FEDERAL],

            #text(18pt)[Santa Catarina],
            #line(length: 50%, stroke: 1pt + rgb("32a041")),
            #text(18pt)[Câmpus \ São José]
        ]
    )
}

#let capa(titulo, subtitulo, curso, disciplina, professor, aluno, data) = {
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
    #line(length: 100%, stroke: 0.5pt)
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
    #text(12pt, weight: "bold")[Aluno]; \
    #text(11pt)[#aluno];
  ]

  align(center + bottom)[
    #data;
  ]

}

#let imagem(arquivo, largura, titulo, autor) = {
  set text(lang: "pt")
  set text(font: "Carlito")
  align(center)[
    // #table(
    //   fill: (col, row) => if calc.odd(row) { white } else {luma(240)} ,
    //   columns: 1,
    //   align: center,
    //   [],
    //   [#image(arquivo, width: largura)],
    //   []

    // )

    #grid(
      columns: (auto),
      rows: 3,
      rect(width: largura, fill: luma(240), stroke: 1pt)[#titulo],
      rect(width: largura)[#image(arquivo, width: largura)],
      rect(width: largura, fill: luma(240), stroke: 1pt)[#autor]
    )
  ]
}
