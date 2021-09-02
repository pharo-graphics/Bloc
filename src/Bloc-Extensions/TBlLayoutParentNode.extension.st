Extension { #name : 'TBlLayoutParentNode' }

{ #category : '*Bloc-Extensions' }
TBlLayoutParentNode >> gtChildrenFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Children';
		priority: 5;
		object: [ self children ];
		view: #gtChildrenFor:
]

{ #category : '*Bloc-Extensions' }
TBlLayoutParentNode >> gtExtentsFor: aView [
	<gtView>

	^ aView text
		title: 'Serialized extents';
		priority: 10;
		text: [
			(String streamContents: [ :aStream |
				aStream tab; nextPut: ${; cr; tab; tab.
				self children extent
					do: [ :eachPoint | aStream print: eachPoint ]
					separatedBy: [ aStream nextPut: $.; cr; tab; tab ].
				aStream cr; tab; nextPut: $} ]) asRopedText glamorousCodeFont ]
]

{ #category : '*Bloc-Extensions' }
TBlLayoutParentNode >> gtMeasuredBoundsFor: aView [
	<gtView>

	^ aView text
		title: 'Serialized bounds';
		priority: 10;
		text: [
			(String streamContents: [ :aStream |
				aStream tab; nextPut: ${; cr; tab; tab.
				self children layoutBounds
					do: [ :eachRectangle | aStream print: eachRectangle ]
					separatedBy: [ aStream nextPut: $.; cr; tab; tab ].
				aStream cr; tab; nextPut: $} ]) asRopedText glamorousCodeFont ]
]

{ #category : '*Bloc-Extensions' }
TBlLayoutParentNode >> gtPreviewFor: aView [
	<gtView>

	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [
			| theNodes theEdges |
			
			theNodes := (self children collect: [ :eachChildNode |
				| aNodeElement |
				
				aNodeElement := BlElement new
					background: (Color gray alpha: 0.4);
					border: (BlBorder paint: Color gray width: 1);
					relocate: eachChildNode layoutBounds origin;
					size: eachChildNode layoutBounds extent.
					
				eachChildNode userData
					at: #label
					ifPresent: [ :aLabel |
						| aLabelElement |
						
						aLabelElement := BlTextElement new.
						aLabelElement text: aLabel asRopedText glamorousCodeFontAndSmallSize.
						aLabelElement constraintsDo: [ :c |
							c ignoreByLayout.
							c ignored horizontal alignCenter.
							c ignored vertical alignCenter ].
						
						aNodeElement addChild: aLabelElement ].
				
				eachChildNode transformationDo: [ :t | aNodeElement transformation: t ].
				
				eachChildNode -> aNodeElement ]) asOrderedDictionary.

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
				"addChildren: theNodesTransformed;"
				addChildren: theNodes values;
				addChildren: theEdges ]
]
