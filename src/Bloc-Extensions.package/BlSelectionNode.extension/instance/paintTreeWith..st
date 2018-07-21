*Bloc-Extensions
paintTreeWith: view
	view nodes
		shape: [ :each |
			BlTextElement new 
				zIndex: 10;
				background: Color white;
				constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
				text: (BlRopedText rope: each selection printString asRopedText) ];
		with: (self withDeepCollect: #children).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #children.
	view layout tree 
		horizontalGap: 20;
		verticalGap: 40