paragraph - geometry
spanAtPoint: aPoint ifFound: aFoundBlock ifNone: anExceptionBlock
	"Find a paragraph span that contains a given point given in a paragraph coordinates
	and evaluate a found block if such span was found or evaluate an exception block
	with the closed span to a point"
	<return: #BrTextparagraphSpan>

	^ self line spans
		findBinary: [ :aParagraphSpan |
			| originX cornerX |
			originX := aParagraphSpan origin x.
			cornerX := originX + aParagraphSpan width.
			(aPoint x between: originX and: cornerX )
				ifTrue: [ 0 ]
				ifFalse: [ | spanCenter |
					spanCenter := originX + ((cornerX - originX) / 2.0).
					aPoint x < spanCenter
						ifTrue: [ -1 ]
						ifFalse: [ 1 ] ] ]
		do: [ :aParagraphSpan | aFoundBlock cull: aParagraphSpan ]
		ifNone: [ :a :b | anExceptionBlock cull: (a ifNil: [ b ] ifNotNil: [ a ]) ]