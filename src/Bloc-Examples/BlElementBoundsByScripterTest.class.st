Class {
	#name : #BlElementBoundsByScripterTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #running }
BlElementBoundsByScripterTest >> expectedElementBounds [

	^ 0 @ 0 extent: self expectedElementExtent
]

{ #category : #running }
BlElementBoundsByScripterTest >> expectedElementExtent [

	^ 500 @ 400
]

{ #category : #running }
BlElementBoundsByScripterTest >> newChild [

	^ BlEventCountingElement new
		id: #child;
		background: (Color veryVeryLightGray alpha: 0.4);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #running }
BlElementBoundsByScripterTest >> newContainer [

	^ BlElement new
		id: #container;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChildren: {
			self newParent1 addChild: self newChild.
			self newParent2 };
		yourself
]

{ #category : #running }
BlElementBoundsByScripterTest >> newDevScripter [

	| aScripter |
	aScripter := BlDevScripter new.
	aScripter element: self newContainer.

	^ aScripter syncContinue
]

{ #category : #running }
BlElementBoundsByScripterTest >> newParent1 [

	^ BlElement new
		id: #parent_1;
		size: self expectedElementExtent;
		border: (BlBorder paint: (Color blue alpha: 0.2) width: 2);
		yourself
]

{ #category : #running }
BlElementBoundsByScripterTest >> newParent2 [

	^ BlElement new
		id: #parent_2;
		size: self expectedElementExtent;
		position: 50 @ 50;
		border: (BlBorder paint: (Color red alpha: 0.2) width: 2);
		yourself
]

{ #category : #tests }
BlElementBoundsByScripterTest >> testBoundsInSpace1 [

	| aScripter |
	aScripter := self newDevScripter.
	aScripter check
		id: #parent_1;
		value: [ :anElement | anElement extent ]
			equals: [ self expectedElementExtent ];
		value: [ :anElement | anElement boundsInSpace ]
			equals: [ self expectedElementBounds ].

	aScripter check
		id: #parent_2;
		value: [ :anElement | anElement extent ]
			equals: [ self expectedElementExtent ];
		value: [ :anElement | anElement boundsInSpace ]
			equals: [ self expectedElementBounds translateBy: 50 @ 50 ].

	aScripter check
		id: #child;
		value: [ :anElement | anElement extent ]
			equals: [ self expectedElementExtent ];
		value: [ :anElement | anElement boundsInSpace ]
			equals: [ self expectedElementBounds ];
		value: [ :anElement | anElement positionInSpaceChangedCount ]
			equals: [ 0 ].

	^ aScripter syncContinue
]

{ #category : #tests }
BlElementBoundsByScripterTest >> testBoundsInSpace2 [

	| aScripter |
	aScripter := self testBoundsInSpace1.

	aScripter do action: [ :anElement |
		| aChild |
		aChild := anElement childWithId: #child.
		aChild removeFromParent.
		(anElement childWithId: #parent_2) addChild: aChild ].

	^ aScripter syncContinue
]

{ #category : #tests }
BlElementBoundsByScripterTest >> testBoundsInSpace3 [
	<expectedFailure>

	| aScripter |
	aScripter := self testBoundsInSpace2.

	aScripter check
		id: #parent_1;
		value: [ :anElement | anElement extent ]
			equals: [ self expectedElementExtent ];
		value: [ :anElement | anElement boundsInSpace ]
			equals: [ self expectedElementBounds ].

	aScripter check
		id: #parent_2;
		value: [ :anElement | anElement extent ]
			equals: [ self expectedElementExtent ];
		value: [ :anElement | anElement boundsInSpace ]
			equals: [ self expectedElementBounds translateBy: 50 @ 50 ].

	aScripter check
		id: #child;
		value: [ :anElement | anElement extent ]
			equals: [ self expectedElementExtent ];
		value: [ :anElement | anElement boundsInSpace ]
			equals: [ self expectedElementBounds translateBy: 50 @ 50 ];
		value: [ :anElement | anElement positionInSpaceChangedCount ]
			equals: [ 1 ].

	^ aScripter syncContinue
]
