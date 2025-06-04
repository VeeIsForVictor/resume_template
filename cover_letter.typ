#import "@preview/oxifmt:0.2.0": strfmt
#let coverLetter(
    author: [],
    mainContact: [],
    address: [],
    mobile: [],
    email: [],
    doccode: "4",
    body
) = {
    set document(
        author: author, 
        title: strfmt("{} CL{}", author, doccode), 
        date: auto
    )

    set text(
        font: "Fira Sans",
        size: 11pt
    )

    let header = block()[
        #set text(
            fill: rgb("1a4674"),
        )
        #show par: set block(spacing: 7pt)
        #show line: set block(spacing: 3pt)

        #grid(
            columns: (1fr, 1fr),
            [= #author],
            align(right)[
                #emph(mainContact)
            ]
        )
        #line(length: 100%, stroke: rgb("ffe052"))
        
        
        #align(right)[
            #set text(size: 9pt)

            #address

            #mobile, #email
        ]

    ]

    set page(
        header: header,
        margin: (
            top: 4cm
        )
    )

    body
}