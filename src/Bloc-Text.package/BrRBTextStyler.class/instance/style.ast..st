private
style: aText ast: ast
	text := aText.
	text attributes: (self attributesFor: #default).
	bracketLevel := 0.
	parentheseLevel := 0.
	ast acceptVisitor: self