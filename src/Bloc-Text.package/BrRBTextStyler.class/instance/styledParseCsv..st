moldability
styledParseCsv: aText
	| aString indices |
	
	aString := aText asString.
	
	indices := Array streamContents: [ :aStream | '(http|https|file)\:\/\/.+\.(csv)' asRegex
		split: aString
		indicesDo: [ :a :b | aStream nextPut: (a -> b) ] ].

	indices size < 2 ifTrue: [ ^ self ].
	
	aText
		attributes: { BrTextBackgroundAttribute paint: Color yellow }
		from: indices first value + 1
		to: indices second key - 1