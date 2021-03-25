Class {
	#name : #BlSpace2Test,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Space'
}

{ #category : #'test seed' }
BlSpace2Test >> animatedElement [
	<gtExample>
	
	^ BlElement new
		background: Color blue;
		size: 150 @ 150;
		relocate: 100 @ 100;
		addAnimation: self infiniteAnimation;
		yourself
]

{ #category : #'test seed' }
BlSpace2Test >> iconElement [
	<gtExample>
	
	^ BlElement new
		  size: 16 @ 16;
		  background: (Color green alpha: 0.5);
		  geometry: BlCircleGeometry new
]

{ #category : #'test seed' }
BlSpace2Test >> iconStencil [
	<gtExample>
	
	| aStencil |
	aStencil := BlSpaceIconDummyStencil new.
	aStencil block: [ self iconElement ].
	^ aStencil
]

{ #category : #'test seed' }
BlSpace2Test >> infiniteAnimation [
	<gtExample>
	
	| anAnimation |
	anAnimation := BlSequentialAnimation new.
	anAnimation add: (BlTransformAnimation scale: 2) absolute.
	anAnimation add: (BlTransformAnimation scale: 0.5) absolute.
	anAnimation beInfinite.
	^ anAnimation
]

{ #category : #'test seed' }
BlSpace2Test >> spaceWithSlownDownTime [
	<gtExample>
	
	| aTime aSpace |
	aTime := BlFastForwardedTime new.
	aTime speed: 0.2.
	aSpace := BlSpace new.
	aSpace time: aTime.
	^ aSpace
]

{ #category : #'test seed' }
BlSpace2Test >> spaceWithSlownDownTimeAndAnimatedElement [
	<gtExample>
	
	| aSpace |
	aSpace := self spaceWithSlownDownTime.
	aSpace root addChild: self animatedElement.
	^ aSpace
]

{ #category : #tests }
BlSpace2Test >> testChangeIcon [
	<gtExample>
	
	| aSpace aCollection |
	aSpace := self testEmptySpace.
	aCollection := OrderedCollection new.
	aSpace
		when: BlSpaceIconChangedEvent
		do: [ :anEvent | aCollection add: anEvent ].
	aSpace icon: self iconStencil.
	self assert: aCollection size equals: 1.
	self assert: aCollection first class equals: BlSpaceIconChangedEvent.
	self
		assert: aCollection first iconStencil class
		equals: BlSpaceIconDummyStencil.
	aSpace icon: aSpace icon.
	self assert: aCollection size equals: 1.

	^ aSpace
]

{ #category : #tests }
BlSpace2Test >> testEmptySpace [
	<gtExample>
	
	| aSpace |
	aSpace := BlSpace new.
	self assert: aSpace session equals: Smalltalk session.
	self deny: aSpace root hasChildren.
	self assert: aSpace dirtyAreas isEmpty.
	self assert: aSpace extent equals: aSpace defaultExtent.
	self assert: aSpace height equals: aSpace defaultExtent y.
	self assert: aSpace width equals: aSpace defaultExtent x.
	self assert: aSpace position equals: 0 @ 0.
	self assert: aSpace resizable.
	self deny: aSpace borderless.
	self deny: aSpace fullscreen.
	self deny: aSpace focused.
	self deny: aSpace hasHostSpace.
	self deny: aSpace hasDirtyAreas.
	self deny: aSpace hasLayoutError.
	self assert: aSpace isLayoutRequested.
	self deny: aSpace isVisible.
	self assert: aSpace title isEmpty.
	self assert: aSpace icon isNil.

	^ aSpace
]

{ #category : #tests }
BlSpace2Test >> testFirstPulse [
	<gtExample>
	
	| aSpace |
	aSpace := self testEmptySpace.
	aSpace pulse.

	self assert: aSpace dirtyAreas isEmpty.
	self assert: aSpace root position equals: 0 @ 0.
	self assert: aSpace root extent equals: aSpace extent.

	^ aSpace
]
