Extension { #name : #BlFocusChain }

{ #category : #'*Bloc-Extensions' }
BlFocusChain >> gtInspectorChainIn: aComposite [
	<gtInspectorPresentationOrder: 5>
	
	^ aComposite blocMondrian
		title: 'Chain';
		painting: [ :view |
			view nodes
				shape: [ :each |
					BlElement new
						geometry: BlEllipse new;
						size: 20@20;
						border: (BlBorder paint: (each isFocused ifTrue: [ Color blue ] ifFalse: [ Color lightGray ]) width: 1) ];
				with: self asArray.
			view edges 
				fromCenterTop;
				toCenterBottom;
				passive; 
				connect: (self asArray select: #hasParent) from: #yourself to: #parent.
				
			view edges 
				fromRightCenter;
				toRightCenter;
				passive;
				shape: [ :anAssociation |
					BlParabollaArcElement new
						curvatureFraction: 0.7;
						border: (anAssociation value hasParent
							ifTrue: [ (BlBorder paint: (Color gray alpha: 0.5) width: 1) ]
							ifFalse: [ BlBorder builder dashed paint: (Color gray alpha: 0.5); width: 1; build ]);
						fromHead:
							(BlArrowheadSimpleArrow new
							arrowLengthFraction: 5;
							arrowNoseAngle: 60;
							border:
								(BlBorder builder
									paint: (Color gray alpha: 0.5);
									width: 1;
									build))  ];
				connect: (self asArray overlappingPairsCollect: [ :a :b | a -> b ]) from: #key to: #value.
				
			view layout horizontalTree ]
]

{ #category : #'*Bloc-Extensions' }
BlFocusChain >> gtInspectorElementsIn: aComposite [
	<gtInspectorPresentationOrder: 10>
	
	^ aComposite fastList
		title: 'Elements';
		display: [ self asArray ]
]
