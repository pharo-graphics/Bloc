Class {
	#name : 'BlElementBoundsByScripterExamples',
	#superclass : 'BlExamplesTest',
	#category : 'Bloc-Examples-Basic',
	#package : 'Bloc-Examples',
	#tag : 'Basic'
}

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_0 [

	<sampleInstance>
	| aScripter |
	aScripter := BlDevScripter new.
	aScripter element: self bounds_in_space_element_container.

	^ aScripter syncContinue
]

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_1 [

	<sampleInstance>
	| aScripter |
	aScripter := self bounds_in_space_0.
	aScripter check
		id: #parent_1;
		value: [ :anElement | anElement extent ]
		equals: [ self bounds_in_space_element_extent ];
		value: [ :anElement | anElement boundsInSpace ]
		equals: [ self bounds_in_space_element_bounds ].

	aScripter check
		id: #parent_2;
		value: [ :anElement | anElement extent ]
		equals: [ self bounds_in_space_element_extent ];
		value: [ :anElement | anElement boundsInSpace ]
		equals: [ self bounds_in_space_element_bounds translateBy: 50 @ 50 ].

	aScripter check
		id: #child;
		value: [ :anElement | anElement extent ]
		equals: [ self bounds_in_space_element_extent ];
		value: [ :anElement | anElement boundsInSpace ]
		equals: [ self bounds_in_space_element_bounds ];
		value: [ :anElement | anElement positionInSpaceChangedCount ]
		equals: [ 0 ].

	^ aScripter syncContinue
]

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_2 [

	<sampleInstance>
	| aScripter |
	aScripter := self bounds_in_space_1.

	aScripter do action: [ :anElement |
		| aChild |
		aChild := anElement childWithId: #child.
		aChild removeFromParent.
		(anElement childWithId: #parent_2) addChild: aChild ].

	^ aScripter syncContinue
]

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_3 [

	<sampleInstance>
	<noTest>
	| aScripter |
	aScripter := self bounds_in_space_2.

	aScripter check
		id: #parent_1;
		value: [ :anElement | anElement extent ]
		equals: [ self bounds_in_space_element_extent ];
		value: [ :anElement | anElement boundsInSpace ]
		equals: [ self bounds_in_space_element_bounds ].

	aScripter check
		id: #parent_2;
		value: [ :anElement | anElement extent ]
		equals: [ self bounds_in_space_element_extent ];
		value: [ :anElement | anElement boundsInSpace ]
		equals: [ self bounds_in_space_element_bounds translateBy: 50 @ 50 ].

	aScripter check
		id: #child;
		value: [ :anElement | anElement extent ]
		equals: [ self bounds_in_space_element_extent ];
		value: [ :anElement | anElement boundsInSpace ]
		equals: [ self bounds_in_space_element_bounds translateBy: 50 @ 50 ];
		value: [ :anElement | anElement positionInSpaceChangedCount ]
		equals: [ 1 ].

	^ aScripter syncContinue
]

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_1 [

	<sampleInstance>
	^ BlElement new
		  id: #parent_1;
		  size: self bounds_in_space_element_extent;
		  border: (BlBorder paint: (Color blue alpha: 0.2) width: 2)
]

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_2 [

	<sampleInstance>
	^ BlElement new
		  id: #parent_2;
		  size: self bounds_in_space_element_extent;
		  position: 50 @ 50;
		  border: (BlBorder paint: (Color red alpha: 0.2) width: 2)
]

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_bounds [

	<sampleInstance>
	^ 0 @ 0 extent: 500 @ 400
]

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_child [

	<sampleInstance>
	^ BlExampleEventsCountingElement new
		  id: #child;
		  background: (Color veryVeryLightGray alpha: 0.4);
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ]
]

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_container [

	<sampleInstance>
	^ BlElement new
		  id: #container;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  addChildren: {
				  (self bounds_in_space_element_1 addChild:
						   self bounds_in_space_element_child).
				  self bounds_in_space_element_2 }
]

{ #category : 'examples - bounds in space' }
BlElementBoundsByScripterExamples >> bounds_in_space_element_extent [

	<sampleInstance>
	^ 500 @ 400
]
