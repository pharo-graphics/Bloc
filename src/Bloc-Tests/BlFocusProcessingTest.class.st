Class {
	#name : #BlFocusProcessingTest,
	#superclass : #BlAbstractEventProcessingTest,
	#category : #'Bloc-Tests-Universe'
}

{ #category : #accessing }
BlFocusProcessingTest >> clearFiredEvents [

	^ space focusProcessor clearFiredEvents
]

{ #category : #accessing }
BlFocusProcessingTest >> firedEvents [

	^ space focusProcessor firedEvents
]

{ #category : #tests }
BlFocusProcessingTest >> testAddFocusedThirdLevelLeaf [

	| childBAA |
	self clearFiredEvents.

	"Add child to BA"
	childBAA :=
		BlElement new
			id: #BAA;
			focused: true;
			yourself.
	self childBA addChild: childBAA.

	self
		assertNextFiredEventIs: BlBlurEvent
		target: self root.
	self
		assertNextFiredEventIs: BlFocusEvent
		target: childBAA.
	self
		assertNextFiredEventIs: BlFocusInEvent
		target: childBAA
]

{ #category : #tests }
BlFocusProcessingTest >> testAddRemovedWithFocus [

	| childBA |
	"Focus on BA, then remove BA"
	childBA := self childBA.
	childBA requestFocus.
	childBA removeFromParent.
	self clearFiredEvents.

	"Both elements have focus, but only B belongs the tree"
	self assert: childBA focused.
	self assert: self childB focused.

	"Add BA again"
	self childB addChild: childBA.
	self
		assertNextFiredEventIs: BlBlurEvent
		target: self childB.
	self
		assertNextFiredEventIs: BlFocusEvent
		target: childBA.
	self
		assertNextFiredEventIs: BlFocusInEvent
		target: childBA.

	"The removed element, BA, takes the focus again"
	self assert: childBA focused.
	self deny: self childB focused

]

{ #category : #tests }
BlFocusProcessingTest >> testAddRemovedWithoutFocus [

	| childBA |
	"Focus on BA, then remove BA"
	childBA := self childBA.
	childBA requestFocus.
	childBA removeFromParent.
	self clearFiredEvents.

	"Add BA again, without focus"
	childBA focused: false.
	self assert: self childB focused.
	self deny: childBA focused.
	self childB addChild: childBA.

	"Nothing changed"
	self assert: self childB focused.
	self deny: childBA focused.

]

{ #category : #tests }
BlFocusProcessingTest >> testInitiallyRootIsFocused [
	"Root receives the focus initially"

	self
		assertFiredEventIs: BlFocusEvent
		target: self root
		withPropagation: false.
	self
		assertFiredEventIs: BlFocusInEvent
		target: self root
		withPropagation: true.

	self deny: self childA focused.
	self assert: self root focused
]

{ #category : #tests }
BlFocusProcessingTest >> testRemoveFocusedContainer [

	| childB |
	self clearFiredEvents.

	"Focus on B"
	childB := self childB.
	childB requestFocus.
	self clearFiredEvents.
	
	childB removeFromParent.

	self
		assertNextFiredEventIs: BlBlurEvent
		target: childB.
	self
		assertNextFiredEventIs: BlFocusOutEvent
		target: childB.
	self
		assertNextFiredEventIs: BlFocusEvent
		target: self root.

	self assert: self root focused.
	self
		assert: childB focused
		description: 'The removed element keeps the focused mark'


]

{ #category : #tests }
BlFocusProcessingTest >> testRemoveFocusedLeaf [

	| childBA |
	"Focus on the leaf BA and remove it"
	childBA := self childBA.
	childBA requestFocus.
	self clearFiredEvents.
	childBA removeFromParent.

	self
		assertNextFiredEventIs: BlBlurEvent
		target: childBA.
	self
		assertNextFiredEventIs: BlFocusOutEvent
		target: childBA.
	self
		assertNextFiredEventIs: BlFocusEvent
		target: self childB.

	self assert: self childB focused.
	self
		assert: childBA focused
		description: 'The removed element keeps the focused mark'
]

{ #category : #tests }
BlFocusProcessingTest >> testSwitchFocusFromNonRootToChild [

	"Focus B"
	self childB requestFocus.
	self clearFiredEvents.

	"Focus BA"
	self childBA requestFocus.

	self
		assertNextFiredEventIs: BlBlurEvent
		target: self childB.
	"The previously focused element, B, is parent of the element that
	receives the focus, BA, that's why B doesn't receive a BlFocusOutEvent."
	self
		assertNextFiredEventIs: BlFocusEvent
		target: self childBA.
	self
		assertNextFiredEventIs: BlFocusInEvent
		target: self childBA.

	self assert: self childBA focused.
	self deny: self childB focused
]

{ #category : #tests }
BlFocusProcessingTest >> testSwitchFocusFromRootToChild [

	self clearFiredEvents.

	"Focus A"
	self childA requestFocus.

	self
		assertNextFiredEventIs: BlBlurEvent
		target: self root.
	"Note: Root has the focus but, as it is a parent it
	doesn't receive BlFocusOutEvent"
	self
		assertNextFiredEventIs: BlFocusEvent
		target: self childA.
	self
		assertNextFiredEventIs: BlFocusInEvent
		target: self childA.

	self assert: self childA focused.
	self deny: self root focused
]

{ #category : #tests }
BlFocusProcessingTest >> testSwitchFocusToSibling [

	"Focus on A"
	self childA requestFocus.
	self clearFiredEvents.

	"Switch focus to B"
	self childB requestFocus.
	self
		assertNextFiredEventIs: BlBlurEvent
		target: self childA.
	self
		assertNextFiredEventIs: BlFocusOutEvent
		target: self childA.
	self
		assertNextFiredEventIs: BlFocusEvent
		target: self childB.
	self
		assertNextFiredEventIs: BlFocusInEvent
		target: self childB.

	self assert: self childB focused.
	self deny: self childA focused
]
