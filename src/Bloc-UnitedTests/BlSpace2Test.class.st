Class {
	#name : 'BlSpace2Test',
	#superclass : 'TestCase',
	#category : 'Bloc-UnitedTests-Space',
	#package : 'Bloc-UnitedTests',
	#tag : 'Space'
}

{ #category : 'test seed' }
BlSpace2Test >> animatedElement [

	<sampleInstance>
	^ BlElement new
		  background: Color blue;
		  size: 150 @ 150;
		  position: 100 @ 100;
		  addAnimation: self infiniteAnimation;
		  yourself
]

{ #category : 'test seed' }
BlSpace2Test >> iconElement [

	<sampleInstance>
	^ BlElement new
		  size: 16 @ 16;
		  background: (Color green alpha: 0.5);
		  geometry: BlCircleGeometry new
]

{ #category : 'test seed' }
BlSpace2Test >> iconStencil [

	<sampleInstance>
	| aStencil |
	aStencil := BlSpaceIconDummyStencil2 new.
	aStencil block: [ self iconElement ].
	^ aStencil
]

{ #category : 'test seed' }
BlSpace2Test >> infiniteAnimation [

	<sampleInstance>
	| anAnimation |
	anAnimation := BlSequentialAnimation new.
	anAnimation add: (BlTransformAnimation scale: 2) absolute.
	anAnimation add: (BlTransformAnimation scale: 0.5) absolute.
	anAnimation beInfinite.
	^ anAnimation
]

{ #category : 'test seed' }
BlSpace2Test >> spaceWithSlownDownTime [

	<sampleInstance>
	| aTime aSpace |
	aTime := BlFastForwardedTime new.
	aTime speed: 0.2.
	aSpace := BlOSpace new.
	aSpace time: aTime.
	^ aSpace
]

{ #category : 'test seed' }
BlSpace2Test >> spaceWithSlownDownTimeAndAnimatedElement [

	<sampleInstance>
	| aSpace |
	aSpace := self spaceWithSlownDownTime.
	aSpace root addChild: self animatedElement.
	^ aSpace
]

{ #category : 'tests' }
BlSpace2Test >> testChangeIcon [

	<sampleInstance>
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
		equals: BlSpaceIconDummyStencil2.
	aSpace icon: aSpace icon.
	self assert: aCollection size equals: 1.

	^ aSpace
]

{ #category : 'tests' }
BlSpace2Test >> testEmptySpace [

	<sampleInstance>
	| aSpace |
	aSpace := BlOSpace new.
	self assert: aSpace session equals: Smalltalk session.
	self deny: aSpace root hasChildren.
	self deny: aSpace hasDirtyElements.
	self assert: aSpace extent equals: aSpace defaultExtent.
	self assert: aSpace height equals: aSpace defaultExtent y.
	self assert: aSpace width equals: aSpace defaultExtent x.
	self assert: aSpace position equals: 0 @ 0.
	self assert: aSpace resizable.
	self deny: aSpace borderless.
	self deny: aSpace fullscreen.
	self deny: aSpace focused.
	self deny: aSpace hasHostSpace.
	self deny: aSpace hasDirtyElements.
	self deny: aSpace hasLayoutError.
	self assert: aSpace isLayoutRequested.
	self deny: aSpace isVisible.
	self assert: aSpace title isEmpty.
	self assert: aSpace icon isNil.

	^ aSpace
]

{ #category : 'tests' }
BlSpace2Test >> testFirstPulse [

	<sampleInstance>
	| aSpace |
	aSpace := self testEmptySpace.
	aSpace pulse.

	self deny: aSpace hasDirtyElements.
	self assert: aSpace root position equals: 0 @ 0.
	self assert: aSpace root extent equals: aSpace extent.

	^ aSpace
]
