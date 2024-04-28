#import "@preview/oxifmt:0.2.0": strfmt

#let contact_box(
  body
) = {
  set text(
    size: 0.85em,
  )

  box(
    width: 100%,
    height: auto,
    fill: rgb("f2f2f2"),
    radius: 20%,
    outset: 11pt,
    body
  )
}

// document-wide template
#let resume(
  author: "",
  doccode: "4",
  subtitle: "",
  contacts: (0,),
  body
) = {
  set document(
    author: author, 
    title: strfmt("{} R{}", author, doccode), 
    date: auto
  )

  set page(
    margin: (
      top: 1.25cm,
      bottom: 1.25cm,
      left: 1.5cm,
      right: 1.5cm,
    ),
    footer: align(right)[
      #set text(size: 10pt)
      This resume was made using #link("https://typst.app")[Typst] with a #link("https://github.com/VeeIsForVanana/resume_template")[template] by Victor Edwin Reyes
    ]
  )
  
  set text(
    font: "Changa",
    size: 11.5pt
  )

  show link: it => underline(text(
      fill: rgb("#0645AD"), [#it]
    ))
  block[
    #align(center)[
      #block(text(weight: 700, 3em)[#smallcaps(author)])
      #linebreak()
      #block(width: auto, height: 5%)[
        #grid(
          columns: (1fr, 1fr, 1fr, 1fr),
          column-gutter: 5%,
          ..contacts.map(contact_box)
        )
      ]
    ]
  ]

  body
}

// section headers

#let section(
  name: ""
) = {
  set text(
    fill: rgb("1a4674")
  )

  [= #name]
  line(length: 100%, stroke: 0.5pt + rgb("ffe052"))
}

// education section

#let edu(
  institution: "",
  duration: "",
  main_attainment: (),
  awards: (),
  gwa: "",
  body
) = {
  
  grid(
    columns: (auto, 1fr), 
    align(left)[
      #strong[#main_attainment] | #institution
    ], 
    align(right)[
      #emph[#duration]
    ]
  )
  
  for award in awards {
    emph[Awarded #award]
  }

  body
}

// skills section

#let skills(
  field: "",
  skills: ()
) = {
  strong[#field: ]
  skills.join(" | ")
}

// experience section

#let exp(
  position: "",
  organization: "",
  duration: "",
  body
) = {
  grid(
    columns: (auto, 1fr), 
    align(left)[
      #strong[#position] | #organization
    ], 
    align(right)[
      #emph[#duration]
    ]
  ) 
  body
}

// projects section

#let proj(
  name: "",
  duration: "",
  body
) = {
  grid(
    columns: (auto, 1fr), 
    align(left)[
      #strong[#name]
    ], 
    align(right)[
      #emph[#duration]
    ]
  )
  body
}