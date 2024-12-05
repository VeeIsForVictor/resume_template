#import "@preview/oxifmt:0.2.0": strfmt

#let contact_box(
  body
) = {
  align(horizon)[
    #set text(
      size: 0.85em,
    )
    #box(
      width: 85%,
      height: auto,
      fill: rgb("f2f2f2"),
      radius: 20%,
      outset: 8pt,
      
    )[
      #align(left)[
        #body
      ]
    ]
  ]
}

// document-wide template
#let resume(
  author: "",
  doccode: "4",
  subtitle: "",
  contacts-l: (0,),
  contacts-r: (0,),
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
      #block(
        fill: rgb(26, 70, 116, 65%),
        width: 100%,
        height: 100%,
        inset: 1%
      )[
        #set text(size: 10pt)
        #set align(horizon)
        This resume was made using #link("https://typst.app")[Typst] with a #link("https://github.com/VeeIsForVanana/resume_template")[template] by Victor Edwin Reyes
      ]
    ]
  )
  
  set text(
    font: "Fira Sans",
    size: 11.2pt
  )

  show link: it => underline(text(
      fill: rgb("#0645AD"), [#it]
    ))
  
  // main header part
  block[
    #align(center)[
      #block(text(weight: 700, 3em)[#smallcaps(author)], below: 1pt)
      #linebreak()
      #block(width: auto, height: 5%)[
        #grid(
          columns: (1fr, 1fr),
          rows: (1fr, 1fr),
          column-gutter: 1%,
          row-gutter: 2fr,
          ..contacts-l.map(contact_box),
          ..contacts-r.map(contact_box),
        )
      ]
    ]
  ]
  linebreak()

  body
}

// section headers and types

#let section(
  name: ""
) = {
  set text(
    fill: rgb("1a4674"),
    weight: "bold"
  )

  [= #name]
  line(length: 100%, stroke: 0.5pt + rgb("ffe052"))
}

#let section2col(
  name: "",
  body
) = {
  grid(
    columns: (1fr, 0.01fr, 4fr),
    align(left)[
      #block(width: 100%)[
        #set text(
          fill: rgb("1a4674"),
          weight: "bold"
        )
        == #name
      ]
    ],
    [],
    align(left)[
      #body
    ]
  )
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
// In the future, we understand *experience* to be a detailing of what *we did* for an organization, emphasizing the responsibilities of the role we take
// For a short-form resume, we would prefer presenting our work as *experience*

#let exp(
  position: "",
  organization: "",
  duration: "",
  url: "",
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
// In the future, we understand *projects* to be a detailing of what the projects *do*
// For a long-form submission or academicia, we would prefer presenting our work as *projects*

#let proj(
  name: "",
  duration: "",
  stack: "",
  url: "",
  body
) = {
  let stackText = {
    if stack != "" {
      [:]
      for stackItem in stack {
        [#box(fill: luma(200), outset: (x: 3pt, y: 2pt), radius: 30%)[ #text(fill: rgb("#004909"))[#stackItem]] #h(5pt)]
      }
    }
  }

  let nameText = {
    if url != "" {
      link(url, text(weight: "bold")[#name])
    } else {
      name
    }
  }

  grid(
    columns: (auto, 1fr), 
    align(left)[
      #nameText #stackText
    ], 
    align(right)[
      #emph[#duration]
    ]
  )
  body
}