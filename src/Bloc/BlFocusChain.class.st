"
I represent a path of elements to the actual focused element.

Even if  ""parent <-> child"" connection between elements is lost due to removing we still have all the necessary information to send FocusOut events.

I am used by ${class:BlFocusProcessor}$ to properly send events
"
Class {
	#name : #BlFocusChain,
	#superclass : #DoubleLinkedList,
	#category : #'Bloc-Space - Support'
}

{ #category : #'instance creation' }
BlFocusChain class >> of: anElement [
	| aChain |
	
	aChain := self new.
	anElement withAllParentsDo: [ :aParent |
		aChain addFirst: aParent ].

	^ aChain
]

{ #category : #'as yet unclassified' }
BlFocusChain >> gtInspectorChainIn: aComposite [
	<gtInspectorPresentationOrder: 5>
	
	^ aComposite blocMondrian
		title: 'Chain';
		painting: [ :view |
			view nodes
				shape: [ :each |
					BlElement new
						geometry: BlEllipseGeometry new;
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

{ #category : #'as yet unclassified' }
BlFocusChain >> gtInspectorElementsIn: aComposite [
	<gtInspectorPresentationOrder: 10>
	
	^ aComposite fastList
		title: 'Elements';
		display: [ self asArray ]
]

{ #category : #enumerating }
BlFocusChain >> leafsDo: aBlock [
	"Evaluate a given block with all leaf elements in the chain starting from the focused element in reverse order"
	| previousElementHadParent |

	previousElementHadParent := false.
	self reverseDo: [ :anElement |
		previousElementHadParent
			ifFalse: [ aBlock value: anElement ].
		previousElementHadParent := anElement value hasParent ]
]
