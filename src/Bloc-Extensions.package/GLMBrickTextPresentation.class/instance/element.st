rendering
element
	| element |
	element := BrEditorElement new editor: (BrTextEditor new text: self formatedDisplayValue asString asRopedText).
	element constraintsDo: [ :c | 
		c vertical matchParent. 
		c horizontal matchParent.		
		c padding: (BlInsets all: 10) ].
	^ element