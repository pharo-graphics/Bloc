rendering
element
	| element |
	element := self newEditorElement editor: (self newEditorModel text: self formatedDisplayValue asString asRopedText).
	element constraintsDo: [ :c | 
		c vertical matchParent. 
		c horizontal matchParent.		
		c padding: (BlInsets all: 10) ].
	^ element