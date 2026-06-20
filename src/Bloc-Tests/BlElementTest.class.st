Class {
	#name : #BlElementTest,
	#superclass : #TestCase,
	#instVars : [
		'space',
		'host'
	],
	#category : #'Bloc-Tests-Basic'
}

{ #category : #'instance creation' }
BlElementTest >> new3LevelsTreeRoot [

	<sampleInstance>
	| parent child1 child2 subChild1 subChild2 |
	parent := BlElement new id: #parent.
	parent extent: 500 asPoint.
	parent background: Color veryLightGray.
	
	child1 := BlElement new id: #child1.
	child1 background: Color red.
	child1 extent: 200 asPoint.
	child1 position: 5 @ 5.
	child2 := BlElement new id: #child2.
	child2 background: Color blue.
	child2 extent: 200 asPoint.
	child2 position: 5 @ 210.

	subChild1 := BlElement new id: #subChild1_1.
	subChild1 background: Color yellow.
	subChild1 extent: 50 asPoint.
	subChild1 position: 5 @ 5.

	subChild2 := BlElement new id: #subChild1_2.
	subChild2 background: Color pink.
	subChild2 extent: 50 asPoint.
	subChild2 position: 5 @ 110.

	child1 addChildren: {
			subChild1.
			subChild2 }.

	subChild1 := BlElement new id: #subChild2_1.
	subChild1 background: Color yellow.
	subChild1 extent: 50 asPoint.
	subChild1 position: 5 @ 5.

	subChild2 := BlElement new id: #subChild2_2.
	subChild2 background: Color pink.
	subChild2 extent: 50 asPoint.
	subChild2 position: 5 @ 110.

	child2 addChildren: {
			subChild1.
			subChild2 }.
	parent addChildren: {
			child1.
			child2 }.
	^ parent
]

{ #category : #'instance creation' }
BlElementTest >> new4LevelsTreeRoot [

	"          A
	         /   \
	       AA     AB
	      / \    / \
	    AAA AAB ABA ABB
	   / \        |
	  AAAA AAAB  ABAA
	"
	| a aa ab aaa aab aba abb aaaa aaab abaa |

	"Level 1"
	a := BlElement new id: #A; yourself.

	"Level 2"
	aa := BlElement new id: #AA; yourself.
	ab := BlElement new id: #AB; yourself.

	"Level 3"
	aaa := BlElement new id: #AAA; yourself.
	aab := BlElement new id: #AAB; yourself.
	aba := BlElement new id: #ABA; yourself.
	abb := BlElement new id: #ABB; yourself.

	"Level 4 - only some nodes have children"
	aaaa := BlElement new id: #AAAA; yourself.
	aaab := BlElement new id: #AAAB; yourself.
	abaa := BlElement new id: #ABAA; yourself.

	"Build tree bottom-up"
	aaa addChildren: { aaaa. aaab }.
	aba addChildren: { abaa }.

	aa addChildren: { aaa. aab }.
	ab addChildren: { aba. abb }.

	a addChildren: { aa. ab }.

	^ a
]

{ #category : #'instance creation' }
BlElementTest >> newElement [

	^ BlElement new
		  extent: 50 @ 50;
		  yourself
]

{ #category : #'instance creation' }
BlElementTest >> newVisibleElement [

	^ self newElement
]

{ #category : #initialization }
BlElementTest >> setUp [

	super setUp.

	host := BlMockedHost new.
	space := BlSpace new.
	space host: host
]

{ #category : #'api - children enumeration' }
BlElementTest >> testAllChildrenBreadthFirstDepthDo [

	| parent idsAndDepths |
	parent := self new3LevelsTreeRoot.
	idsAndDepths := OrderedCollection new.
	parent allChildrenBreadthFirstWithDepthDo: [ :child :depth |
		idsAndDepths add: child id -> depth ].
	self
		assert: idsAndDepths asArray
		equals: {#child1->1. #child2->1. #subChild1_1->2. #subChild1_2->2. #subChild2_1->2. #subChild2_2->2}
]

{ #category : #'api - children enumeration' }
BlElementTest >> testAllChildrenBreadthFirstDepthDo2 [

	| parent idsAndDepths |
	parent := self new4LevelsTreeRoot.
	idsAndDepths := OrderedCollection new.
	parent allChildrenBreadthFirstWithDepthDo: [ :child :depth | idsAndDepths add: child id -> depth ].
	self
		assert: idsAndDepths asArray
		equals: { #AA->1. #AB->1. #AAA->2. #AAB->2. #AAAA->3. #AAAB->3. #ABA->2. #ABB->2. #ABAA->3 }
]

{ #category : #'api - children enumeration' }
BlElementTest >> testAllChildrenBreadthFirstDo [

	| parent allElements |
	parent := self new3LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent allChildrenBreadthFirstDo: [ :child | allElements add: child ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals:
			#(#child1 #child2 #subChild1_1 #subChild1_2 #subChild2_1 #subChild2_2)
]

{ #category : #'api - children enumeration' }
BlElementTest >> testAllChildrenBreadthFirstDo2 [

	self
		assert: (Array streamContents: [ :stream |
			self new4LevelsTreeRoot allChildrenBreadthFirstDo: [ :aChild | stream nextPut: aChild id ] ])
		equals: #(#AA #AB #AAA #AAB #ABA #ABB #AAAA #AAAB #ABAA)
]

{ #category : #'api - children enumeration' }
BlElementTest >> testAllChildrenBreadthFirstDoWhile [

	| parent allElements |
	parent := self new4LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent
		allChildrenBreadthFirstDo: [ :child | allElements add: child ]
		while: [ :e | e hasChildren ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals:  #(#AA #AB #AAA #ABA)
]

{ #category : #'api - children enumeration' }
BlElementTest >> testAllChildrenDepthFirstDo [

	| parent allElements |
	parent := self new3LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent allChildrenDepthFirstDo: [ :child | allElements add: child ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals:
		#( #subChild1_1 #subChild1_2 #subChild2_1 #subChild2_2 #child1
		   #child2 )
]

{ #category : #'api - children enumeration' }
BlElementTest >> testAllChildrenDepthFirstDoWhile [

	| parent allElements |
	parent := self new3LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent
		allChildrenDepthFirstDo: [ :child | allElements add: child ]
		while: [ :e | e hasChildren ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals: #( #child1 #child2 )
]

{ #category : #'children - accessing' }
BlElementTest >> testChildWithId [

	| blElement blChild error |
	blElement := self newElement.

	"Test with nil key (simulate an malfunction)"
	error := nil.
	[ blElement childWithId: nil ] onErrorDo: [ :e | error := e ].
	self assert: error notNil.

	"Test with no-existing child key"
	error := nil.
	[ blElement childWithId: #aChild ] onErrorDo: [ :e | error := e ].
	self assert: error notNil.

	"Test with existing child key"
	blChild := BlElement id: #aChild.
	blElement addChild: blChild.
	self assert: (blElement childWithId: #aChild) equals: blChild
]

{ #category : #'children - accessing' }
BlElementTest >> testChildWithIdIfFound [

	| blElement blChild result |
	blElement := self newElement.

	"Test with nil key (simulate an malfunction)"
	result := blElement childWithId: nil ifFound: [ :e | true ].
	self assert: result isNil.
	result := blElement childWithId: nil ifFound: [ true ]. "cull version"
	self assert: result isNil.

	"Test with no-existing child key"
	result := blElement childWithId: #aChild ifFound: [ :e | true ].
	self assert: result isNil.
	result := blElement childWithId: #aChild ifFound: [ true ]. "cull version"
	self assert: result isNil.

	"Test with existing child key"
	blChild := BlElement id: #aChild.
	blElement addChild: blChild.
	result := blElement childWithId: #aChild ifFound: [ :e | e ].
	self assert: result equals: blChild.

	result := blElement childWithId: #aChild ifFound: [ true ]. "cull version"
	self assert: result
]

{ #category : #'children - accessing' }
BlElementTest >> testChildWithIdIfFoundIfNone [

	| blElement blChild result |
	blElement := self newElement.

	"Test with nil key (simulate an malfunction)"
	result := blElement
		          childWithId: nil
		          ifFound: [ :e | true ]
		          ifNone: [ false ].
	self assert: result not.
	result := blElement
		          childWithId: nil
		          ifFound: [ true ]
		          ifNone: [ false ]. "cull version"
	self assert: result not.

	"Test with no-existing child key"
	result := blElement
		          childWithId: #aChild
		          ifFound: [ :e | true ]
		          ifNone: [ false ].
	self assert: result not.
	result := blElement
		          childWithId: #aChild
		          ifFound: [ true ]
		          ifNone: [ false ]. "cull version"
	self assert: result not.

	"Test with existing child key"
	blChild := BlElement id: #aChild.
	blElement addChild: blChild.
	result := blElement
		          childWithId: #aChild
		          ifFound: [ :e | e ]
		          ifNone: [ false ].
	self assert: result equals: blChild.

	result := blElement
		          childWithId: #aChild
		          ifFound: [ true ]
		          ifNone: [ false ]. "cull version"
	self assert: result
]

{ #category : #'children - accessing' }
BlElementTest >> testChildWithIdIfNone [

	| blElement blChild |
	blElement := self newElement.

	"Test with nil key (simulate an malfunction)"
	self assert: (blElement childWithId: nil ifNone: [ true ]).

	"Test with no-existing child key"
	self assert: (blElement childWithId: #aChild ifNone: [ true ]).

	"Test with existing child key"
	blChild := BlElement id: #aChild.
	blElement addChild: blChild.
	self
		assert: (blElement childWithId: #aChild ifNone: [ true ])
		equals: blChild
]

{ #category : #default }
BlElementTest >> testDefault [

	| element |
	element := self newElement.

	self assert: element position equals: 0 @ 0.
	self assert: element extent equals: 0 @ 0
]

{ #category : #'focus testing' }
BlElementTest >> testHasFocus [

	| element child |
	element := self newElement.
	child := self newElement.

	element addChild: child.
	space root addChild: element.
	self assert: element hasFocus not.
	self assert: child hasFocus not.

	element focused: true.
	self assert: element hasFocus.
	self assert: child hasFocus not.

	element focused: false.
	child focused: true.

	self assert: element hasFocus.
	self assert: child hasFocus
]

{ #category : #'focus testing' }
BlElementTest >> testHasFocusable [

	| element child |
	element := self newElement.
	child := self newElement.
	element addChild: child.

	self assert: element hasFocusable.
	self assert: child hasFocusable.

	element visibility: BlVisibility hidden.
	self assert: element hasFocusable.
	self assert: child hasFocusable.

	child visibility: BlVisibility hidden.
	self assert: element hasFocusable not.
	self assert: child hasFocusable not.

	element visibility: BlVisibility visible.
	self assert: element hasFocusable.
	self assert: child hasFocusable not.

	child visibility: BlVisibility visible.
	self assert: element hasFocusable.
	self assert: child hasFocusable
]

{ #category : #tests }
BlElementTest >> testId [

	| element |
	element := BlElement new.
	element id: #anId.
	
	self assert: element id equals: #anId.
]

{ #category : #tests }
BlElementTest >> testIdConstructor [

	| element |
	element := BlElement id: #anId.
	
	self assert: element id equals: #anId.
]

{ #category : #'focus testing' }
BlElementTest >> testIsFocusable [

	| element |
	element := self newElement.
	self assert: element isFocusable.

	element visibility: BlVisibility gone.
	self assert: element isFocusable not.

	element visibility: BlVisibility hidden.
	self assert: element isFocusable not.

	element visibility: BlVisibility visible.
	self assert: element isFocusable.

	element visibility: BlVisibility visible.
	self assert: element isFocusable.

	element preventMouseEvents.
	self assert: element isFocusable not.

	element allowMouseEvents.
	self assert: element isFocusable
]

{ #category : #'focus testing' }
BlElementTest >> testIsFocused [

	| element |
	element := self newElement.

	space root addChild: element.
	self assert: element isFocused not.

	element focused: true.
	self assert: element isFocused
]

{ #category : #printing }
BlElementTest >> testPrintOn [

	| element hash |
	element := self newElement.
	hash := element identityHash.
	
	self assert: element printString equals: ('BlElement @ ', hash printString)
]

{ #category : #'children - add/remove' }
BlElementTest >> testRemoveChildWithId [

	| element child |
	element := self newElement.
	child := BlElement id: #child1.
	element addChild: child.	
	self assert: element childrenCount equals: 1.
	
	element removeChildWithId: #child2.
	self assert: element childrenCount equals: 1.
	
	element removeChildWithId: #child1.
	self assert: element childrenCount equals: 0.

]

{ #category : #'focus requesting' }
BlElementTest >> testRequestFocus [

	| element child another elementEvents childEvents anotherEvents |
	elementEvents := OrderedCollection new.
	childEvents := OrderedCollection new.
	anotherEvents := OrderedCollection new.

	element := self newElement.
	element
		addEventHandlerOn: BlFocusEvent
		do: [ :anEvent | elementEvents add: anEvent ].
	element
		addEventHandlerOn: BlBlurEvent
		do: [ :anEvent | elementEvents add: anEvent ].
	child := self newElement.
	child
		addEventHandlerOn: BlFocusEvent
		do: [ :anEvent | childEvents add: anEvent ].
	child
		addEventHandlerOn: BlBlurEvent
		do: [ :anEvent | childEvents add: anEvent ].
	another := self newElement.
	another
		addEventHandlerOn: BlFocusEvent
		do: [ :anEvent | anotherEvents add: anEvent ].
	another
		addEventHandlerOn: BlBlurEvent
		do: [ :anEvent | anotherEvents add: anEvent ].

	another addChild: child.
	space root addChildren: {
			element.
			another }.

	self assert: element isFocused not.
	self assert: child isFocused not.
	self assert: another isFocused not.
	self assert: elementEvents size equals: 0.
	self assert: anotherEvents size equals: 0.
	self assert: childEvents size equals: 0.

	element requestFocus.
	self assert: element isFocused.
	self assert: child isFocused not.
	self assert: another isFocused not.
	self assert: elementEvents size equals: 1.
	self assert: elementEvents first isFocus.
	self assert: elementEvents first target == element.
	self assert: anotherEvents size equals: 0.
	self assert: childEvents size equals: 0.
	elementEvents removeAll.

	another requestFocus.
	self assert: element isFocused not.
	self assert: child isFocused not.
	self assert: another isFocused.
	self assert: elementEvents size equals: 1.
	self assert: elementEvents first isBlur.
	self assert: elementEvents first target == element.
	self assert: anotherEvents size equals: 1.
	self assert: anotherEvents first isFocus.
	self assert: anotherEvents first target == another.
	self assert: childEvents size equals: 0.
	elementEvents removeAll.
	anotherEvents removeAll.

	child requestFocus.
	self assert: element isFocused not.
	self assert: child isFocused.
	self assert: another isFocused not.
	self assert: elementEvents size equals: 0.
	self assert: anotherEvents size equals: 1.
	self assert: anotherEvents first isBlur.
	self assert: anotherEvents first target == another.
	self assert: childEvents size equals: 1.
	self assert: childEvents first isFocus.
	self assert: childEvents first target == child
]

{ #category : #'api - children enumeration' }
BlElementTest >> testSelectChildrenWithId [

	| element child list child2 |
	element := self newElement.
	list := element selectChildrenWithId: #child1.
	self assert: list isEmpty.
	
	child := BlElement id: #child1.
	element addChild: child.
	list := element selectChildrenWithId: #child1.
	self assert: list size equals: 1.
	self assert: list first identicalTo: child.
	
	child2 := BlElement id: #child1.
	element addChild: child2.
	list := element selectChildrenWithId: #child1.
	self assert: list size equals: 2.
	self assert: list first identicalTo: child.
	self assert: list second identicalTo: child2.
]

{ #category : #'api - children enumeration' }
BlElementTest >> testWithAllChildrenBreadthFirst [

	| parent ids |
	parent := self new3LevelsTreeRoot.
	ids := parent withAllChildrenBreadthFirst collect: [ :child | child id ] as: Array.

	self
		assert: ids
		equals: #(#parent #child1 #child2 #subChild1_1 #subChild1_2 #subChild2_1 #subChild2_2)
]

{ #category : #'api - children enumeration' }
BlElementTest >> testWithAllChildrenBreadthFirst2 [

	| parent ids |
	parent := self new4LevelsTreeRoot.
	ids := parent withAllChildrenBreadthFirst collect: [ :child | child id ] as: Array.

	self
		assert: ids
		equals: #(#A #AA #AB #AAA #AAB #ABA #ABB #AAAA #AAAB #ABAA)
]

{ #category : #'api - children enumeration' }
BlElementTest >> testWithAllChildrenBreadthFirstDo [

	| parent allElements |
	parent := self new3LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent withAllChildrenBreadthFirstDo: [ :child | allElements add: child ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals:
			#( #parent #child1 #child2 #subChild1_1 #subChild1_2 #subChild2_1
			   #subChild2_2 )
]

{ #category : #'api - children enumeration' }
BlElementTest >> testWithAllChildrenBreadthFirstDo2 [

	| parent allElements |
	parent := self new4LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent withAllChildrenBreadthFirstDo: [ :child | allElements add: child ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals: #(#A #AA #AB #AAA #AAB #ABA #ABB #AAAA #AAAB #ABAA)
]

{ #category : #'api - children enumeration' }
BlElementTest >> testWithAllChildrenBreadthFirstDoWhile [

	| parent allElements |
	parent := self new3LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent
		withAllChildrenBreadthFirstDo: [ :child | allElements add: child ]
		while: [ :e | e hasChildren ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals: #( #parent #child1 #child2 )
]

{ #category : #'api - children enumeration' }
BlElementTest >> testWithAllChildrenBreadthFirstDoWhile2 [

	| parent allElements |
	parent := self new4LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent
		withAllChildrenBreadthFirstDo: [ :child | allElements add: child ]
		while: [ :e | e hasChildren ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals:  #(#A #AA #AB #AAA #ABA)
]

{ #category : #'api - children enumeration' }
BlElementTest >> testWithAllChildrenDepthFirstDo [

	| parent allElements |
	parent := self new3LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent withAllChildrenDepthFirstDo: [ :child |
		allElements add: child ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals:
			#( #subChild1_1 #subChild1_2 #subChild2_1 #subChild2_2 #child1
			   #child2 #parent )
]

{ #category : #'api - children enumeration' }
BlElementTest >> testWithAllChildrenDepthFirstDoWhile [

	| parent allElements |
	parent := self new3LevelsTreeRoot.
	allElements := OrderedCollection new.
	parent
		withAllChildrenDepthFirstDo: [ :child | allElements add: child ]
		while: [ :e | e hasChildren ].
	self
		assert: (allElements collect: [ :e | e id asSymbol ]) asArray
		equals: #( #child1 #child2 #parent)
]
