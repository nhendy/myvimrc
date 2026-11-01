#set document(title: "Untitled", author: "Nour Hendy")
#set page(paper: "a4", margin: 2cm, numbering: "1")
#set par(justify: true)
#set heading(numbering: "1.1")
#set math.equation(numbering: "(1)")

// --- math shortcuts I always want (edit freely) ---
#let abs(x) = $lr(|#x|)$
#let norm(x) = $lr(|| #x ||)$
#let inner(a, b) = $lr(angle.l #a, #b angle.r)$
#let dd = $upright(d)$
// Built-in already (no macro needed): Greek (alpha, pi, Gamma),
// blackboard bold (RR, ZZ, NN, QQ, CC), arrows (->, =>, |->), accents (hat(x), dot(x)).

// --- lightweight theorem-like blocks ---
#let theorem(body) = block(fill: luma(240), inset: 8pt, radius: 4pt, [*Theorem.* #body])
#let definition(body) = block(stroke: 0.5pt, inset: 8pt, radius: 4pt, [*Definition.* #body])

#align(center)[
  #text(17pt, weight: "bold")[Untitled] \
  Nour Hendy #h(1em) #datetime.today().display("[year]-[month]-[day]")
]

=
