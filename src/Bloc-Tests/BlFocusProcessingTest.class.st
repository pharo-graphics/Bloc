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
	self assert: childBA isFocused.
	self assert: self childB isFocused.

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
	self assert: childBA isFocused.
	self deny: self childB isFocused

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
	self assert: self childB isFocused.
	self deny: childBA isFocused.
	self childB addChild: childBA.

	"Nothing changed"
	self assert: self childB isFocused.
	self deny: childBA isFocused.

]

{ #category : #tests }
BlFocusProcessingTest >> testFocusDelegationLoseFocus [
	"Demonstrates that sending loseFocus to a container element redirects
	blur processing to its focusDelegate."

	| container leaf |
	container := BlMockFocusDelegatingElement new.
	leaf := BlElement new.
	container addChild: leaf.
	container focusDelegate: leaf.
	space deferAndSettle: [ space root addChild: container ].

	container requestFocus.
	self assert: leaf isFocusOwner.
	self assert: container isFocused.
	self clearFiredEvents.

	"Lose focus from the container element"
	container loseFocus.
	self deny: leaf isFocusOwner.
	self deny: leaf isFocused.
	self deny: container isFocused.
	self deny: container hasFocus.
	self deny: leaf hasFocus.

	self
		assertNextFiredEventIs: BlBlurEvent
		target: leaf.
	self
		assertNextFiredEventIs: BlFocusOutEvent
		target: leaf.
	self assertEmpty: self firedEvents
]

{ #category : #tests }
BlFocusProcessingTest >> testFocusDelegationMultiLevel [
	"Demonstrates multi-level focus delegation (e.g. Outer Container -> Inner Container -> Leaf element)."

	| outerContainer innerContainer leaf |
	outerContainer := BlMockFocusDelegatingElement new.
	innerContainer := BlMockFocusDelegatingElement new.
	leaf := BlElement new.

	outerContainer addChild: innerContainer.
	innerContainer addChild: leaf.

	outerContainer focusDelegate: innerContainer.
	innerContainer focusDelegate: leaf.

	space deferAndSettle: [ space root addChild: outerContainer ].

	"Request focus on the outermost container element"
	outerContainer requestFocus.

	"Only the terminal leaf is the focusOwner"
	self assert: leaf isFocusOwner.
	self deny: innerContainer isFocusOwner.
	self deny: outerContainer isFocusOwner.

	"All three levels are logically focused"
	self assert: leaf isFocused.
	self assert: innerContainer isFocused.
	self assert: outerContainer isFocused.

	"All three levels have focus in their subtree"
	self assert: leaf hasFocus.
	self assert: innerContainer hasFocus.
	self assert: outerContainer hasFocus
]

{ #category : #tests }
BlFocusProcessingTest >> testFocusDelegationToDescendant [
	"Demonstrates focus delegation to a descendant element:
	A container element delegates focus to a descendant element (the focusDelegate).

	When the container element requests focus:
	1. The descendant becomes the space's focusOwner (isFocusOwner = true).
	2. The container element is not the focusOwner (isFocusOwner = false).
	3. The container element isFocused = true (delegates to its focusDelegate).
	4. Both elements haveFocus = true (focus is within their subtree).
	5. Only the descendant receives the non-bubbling BlFocusEvent."

	| container leaf |
	container := BlMockFocusDelegatingElement new.
	leaf := BlElement new.
	container addChild: leaf.
	container focusDelegate: leaf.
	space deferAndSettle: [ space root addChild: container ].

	"Initially root has focus"
	self assert: self root isFocusOwner.
	self deny: container isFocused.
	self deny: leaf isFocused.

	"Request focus on the container element"
	self clearFiredEvents.
	container requestFocus.

	"The descendant leaf is the focusOwner in the space"
	self assert: leaf isFocusOwner.
	self deny: container isFocusOwner.

	"Both answer true to isFocused"
	self assert: leaf isFocused.
	self assert: container isFocused.

	"Both answer true to hasFocus"
	self assert: leaf hasFocus.
	self assert: container hasFocus.

	"BlFocusEvent was dispatched to the descendant leaf, not the container element"
	self
		assertNextFiredEventIs: BlBlurEvent
		target: self root.
	self
		assertNextFiredEventIs: BlFocusEvent
		target: leaf.
	self
		assertNextFiredEventIs: BlFocusInEvent
		target: leaf.
	self assertEmpty: self firedEvents
]

{ #category : #tests }
BlFocusProcessingTest >> testFocusDelegationWithUnfocusableDelegate [
	"Demonstrates that requesting focus on a container element is rejected if its focus delegate is unfocusable."

	| container leaf |
	container := BlMockFocusDelegatingElement new.
	leaf := BlElement new.
	container addChild: leaf.
	container focusDelegate: leaf.
	space deferAndSettle: [ space root addChild: container ].

	leaf focusability: BlFocusability none.
	self clearFiredEvents.

	container requestFocus.
	self assert: self root isFocusOwner.
	self deny: leaf isFocusOwner.
	self deny: container isFocused.
	self assertEmpty: self firedEvents
]

{ #category : #tests }
BlFocusProcessingTest >> testFocusHolderBackwardCompatibility [
	"Demonstrates that #focusHolder continues to answer the same element as #focusDelegate."

	| container leaf |
	container := BlMockFocusDelegatingElement new.
	leaf := BlElement new.
	container addChild: leaf.
	container focusDelegate: leaf.

	self assert: container focusHolder identicalTo: leaf.
	self assert: container focusDelegate identicalTo: leaf.

	self assert: leaf focusHolder identicalTo: leaf.
	self assert: leaf focusDelegate identicalTo: leaf
]

{ #category : #tests }
BlFocusProcessingTest >> testHasFocus [

	self clearFiredEvents.

	"Initially root has focus"
	self assert: self root hasFocus.
	self deny: self childA hasFocus.
	self deny: self childB hasFocus.
	self deny: self childBA hasFocus.

	"Focus on childBA: childBA, childB, and root all have focus"
	self childBA requestFocus.
	self assert: self childBA hasFocus.
	self assert: self childB hasFocus.
	self assert: self root hasFocus.
	self deny: self childA hasFocus
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

	self deny: self childA isFocused.
	self assert: self root isFocused
]

{ #category : #tests }
BlFocusProcessingTest >> testIsFocusOwner [

	| childBA |
	self clearFiredEvents.

	"Initially root has focus"
	self assert: self root isFocusOwner.
	self deny: self childA isFocusOwner.
	self deny: self childB isFocusOwner.
	self deny: self childBA isFocusOwner.

	"Focus on childBA"
	childBA := self childBA.
	childBA requestFocus.
	self assert: childBA isFocusOwner.
	self deny: self childB isFocusOwner.
	self deny: self childA isFocusOwner.
	self deny: self root isFocusOwner.

	"When childBA is removed from parent, it loses primary focus"
	childBA removeFromParent.
	self deny: childBA isFocusOwner.
	self assert: self childB isFocusOwner
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

	self assert: self root isFocused.
	self
		assert: childB isFocused
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

	self assert: self childB isFocused.
	self
		assert: childBA isFocused
		description: 'The removed element keeps the focused mark'
]

{ #category : #tests }
BlFocusProcessingTest >> testRequestFocusWhenFocusabilityNoneOrIgnore [
	"Demonstrates that elements with focusability none or ignore cannot take focus."

	{ BlFocusability none. BlFocusability ignore } do: [ :aFocusability |
		self root requestFocus.
		self assert: self root isFocusOwner.
		self clearFiredEvents.

		self childA focusability: aFocusability.
		self deny: self childA isFocusable.

		self childA requestFocus.
		self assert: self root isFocusOwner.
		self deny: self childA isFocusOwner.
		self assertEmpty: self firedEvents ]
]

{ #category : #tests }
BlFocusProcessingTest >> testRequestFocusWhenFocusableModes [
	"Demonstrates that elements with before, after, or block focusability can take focus."

	{ BlFocusability before. BlFocusability after. BlFocusability block } do: [ :aFocusability |
		self root requestFocus.
		self assert: self root isFocusOwner.
		self clearFiredEvents.

		self childA focusability: aFocusability.
		self assert: self childA isFocusable.

		self childA requestFocus.
		self assert: self childA isFocusOwner.
		self deny: self root isFocusOwner ]
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

	self assert: self childBA isFocused.
	self deny: self childB isFocused
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

	self assert: self childA isFocused.
	self deny: self root isFocused
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

	self assert: self childB isFocused.
	self deny: self childA isFocused
]
