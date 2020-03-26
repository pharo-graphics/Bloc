Extension { #name : #BlSelectionNode }

{ #category : #'*Bloc-Extensions' }
BlSelectionNode >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #'*Bloc-Extensions' }
BlSelectionNode >> paintTreeWith: view [
	view nodes
		shape: [ :each |
			BlElement new
				layout: BlLinearLayout vertical alignCenter;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				padding: (BlInsets all: 13);
				geometry: (BlCircle new);
				border: (BlBorder paint: Color black width: 1);
				background: Color white;
				zIndex: 10;
				addChildren: {
					BlTextElement new
						constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
						text: each selection printString asRopedText.
					BlTextElement new
						constraintsDo: [ :c | c padding: (BlInsets all: 2) ];
						text: each high asString asRopedText thin } ];
		with: (self withDeepCollect: #children).
	view edges
		fromNearestTightCircle;
		toNearestTightCircle;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #children.
	view layout tree 
		nodeDistance: 10;
		levelDistance: 20
]
