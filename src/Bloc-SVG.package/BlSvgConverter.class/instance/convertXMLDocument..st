converting
convertXMLDocument: doc
	| root |
	root := doc nodes elements.
	((root size > 1) or: [ root first name ~= 'svg'])  ifTrue: [ self error: 'A root svg element expected' ].
	
	self factory reset.
	^self factory svgFrom: (root first).
