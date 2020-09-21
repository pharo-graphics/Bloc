Extension { #name : #BlLayoutParentNode }

{ #category : #'*Bloc-Extensions' }
BlLayoutParentNode >> gtChildrenFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Children';
		priority: 5;
		object: [ self children ];
		view: #gtChildrenFor:
]

{ #category : #'*Bloc-Extensions' }
BlLayoutParentNode >> gtMeasuredBoundsFor: aView [
	<gtView>

	^ aView text
		title: 'Serialized bounds';
		priority: 10;
		text: [
			(String streamContents: [ :aStream |
				aStream tab; nextPut: ${; cr; tab; tab.
				self children measuredBounds
					do: [ :eachRectangle | aStream print: eachRectangle ]
					separatedBy: [ aStream nextPut: $.; cr; tab; tab ].
				aStream cr; tab; nextPut: $} ]) asRopedText glamorousCodeFont ]
]

{ #category : #'*Bloc-Extensions' }
BlLayoutParentNode >> gtPreviewFor: aView [
	<gtView>

	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [
			| theNodes theEdges |
			
			theNodes := (self children collect: [ :eachChildNode |
				eachChildNode ->( BlElement new
					background: (Color gray alpha: 0.4);
					border: (BlBorder paint: Color gray width: 1);
					relocate: eachChildNode measurement position;
					size: eachChildNode measurement extent) ]) asOrderedDictionary.
			
			theEdges := self children flatCollect: [ :eachChildNode |
				(eachChildNode isKindOf: BlLayoutChildNodeWithEdges)
					ifTrue: [
						eachChildNode connectedEdges collect: [ :eachEdge |
							BlLineElement  new
								zIndex: 10;
								border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
								fromAnchor: (BlElementCenterAnchor element: (theNodes at: eachEdge fromNode));
								toAnchor: (BlElementCenterAnchor element: (theNodes at: eachEdge toNode));
								toHead: (BlArrowheadSimpleArrow new
									arrowLengthFraction: 7;
									border: (BlBorder builder paint: (Color gray alpha: 0.8); width: 1; build))
						]
					]
					ifFalse: [ #() ]
			].
			
			BlElement new
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				addChildren: theNodes values;
				addChildren: theEdges ]
]
