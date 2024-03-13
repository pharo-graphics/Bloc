"
I contain example of how to use space
"
Class {
	#name : #BlSpaceExamplesMigratedTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Space'
}

{ #category : #running }
BlSpaceExamplesMigratedTest >> newAnimatedElement [

	| anAnimation |
	anAnimation := BlSequentialAnimation new.
	anAnimation add: (BlTransformAnimation scale: 2) absolute.
	anAnimation add: (BlTransformAnimation scale: 0.5) absolute.
	anAnimation beInfinite.

	^ BlElement new
		  background: Color blue;
		  size: 150 @ 150;
		  position: 100 @ 100;
		  addAnimation: anAnimation;
		  yourself
]

{ #category : #running }
BlSpaceExamplesMigratedTest >> newIconElement [

	^ BlElement new
		size: 16@16;
		background: (Color green alpha: 0.5);
		geometry: BlCircleGeometry new;
		yourself
]

{ #category : #running }
BlSpaceExamplesMigratedTest >> newIconStencil [

	^ BlSpaceIconDummyStencil new
			block: [ self newIconElement ];
			yourself
]

{ #category : #running }
BlSpaceExamplesMigratedTest >> newSpaceWithSlownDownTime [

	| aTime aSpace |
	aTime := BlFastForwardedTime new.
	aTime speed: 0.2.
	aSpace := BlSpace new.
	aSpace time: aTime.
	^ aSpace
]

{ #category : #running }
BlSpaceExamplesMigratedTest >> newSpaceWithSlownDownTimeAndAnimatedElement [

	| aSpace |
	aSpace := self newSpaceWithSlownDownTime.
	aSpace root addChild: self newAnimatedElement.
	^ aSpace
]

{ #category : #tests }
BlSpaceExamplesMigratedTest >> testChangeIcon [

	| aSpace aCollection |
	aSpace := BlSpace new.

	aCollection := OrderedCollection new.
	aSpace addEventHandler: (BlEventHandler
			 on: BlSpaceIconChangedEvent
			 do: [ :anEvent | aCollection add: anEvent ]).

	aSpace icon: self newIconStencil.

	self assert: aCollection size equals: 1.
	self assert: aCollection first class equals: BlSpaceIconChangedEvent.
	self
		assert: aCollection first iconStencil class
		equals: BlSpaceIconDummyStencil.

	aSpace icon: aSpace icon.
	self assert: aCollection size equals: 1
]

{ #category : #tests }
BlSpaceExamplesMigratedTest >> testEmptySpace [

	| aSpace |
	aSpace := BlSpace new.

	self assert: aSpace session equals: Smalltalk session.
	self assert: aSpace root hasChildren not.
	self deny: aSpace hasDirtyElements.
	self assert: aSpace extent equals: aSpace defaultExtent.
	self assert: aSpace height equals: aSpace defaultExtent y.
	self assert: aSpace width equals: aSpace defaultExtent x.
	self assert: aSpace position equals: 0 @ 0.
	self assert: aSpace isResizable.
	self assert: aSpace isBorderless not.
	self assert: aSpace isFullscreen not.
	self assert: aSpace isFocused not.
	self assert: aSpace hasHostSpace not.
	self deny: aSpace hasDirtyElements.
	self assert: aSpace hasLayoutError not.
	self assert: aSpace isLayoutRequested.
	self assert: aSpace isVisible not.
	self assert: aSpace title isEmpty.
	self assert: aSpace icon isNil
]

{ #category : #tests }
BlSpaceExamplesMigratedTest >> testFirstPulse [

	| aSpace |
	aSpace := BlSpace new.

	aSpace pulse.

	self deny: aSpace hasDirtyElements.
	self assert: aSpace root position equals: 0 @ 0.
	self assert: aSpace root extent equals: aSpace extent
]
