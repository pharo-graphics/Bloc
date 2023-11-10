"
I contain example of how to use space
"
Class {
	#name : #BlSpaceExamplesMigratedTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-SpaceMigrated'
}

{ #category : #script }
BlSpaceExamplesMigratedTest class >> slownDownSpace [
	<script: 'self slownDownSpace'>
	
	self new spaceWithSlownDownTimeAndAnimatedElement
		extent: 350@350;
		show
]

{ #category : #'private - instance creation' }
BlSpaceExamplesMigratedTest >> animatedElement [

	<simpleInstance>
	^ BlElement new
		  background: Color blue;
		  size: 150 @ 150;
		  position: 100 @ 100;
		  addAnimation: self testInfiniteAnimation
]

{ #category : #'examples - icon' }
BlSpaceExamplesMigratedTest >> iconElement [
	<sampleInstance>
	^ BlElement new
		size: 16@16;
		background: (Color green alpha: 0.5);
		geometry: BlCircleGeometry new.
]

{ #category : #'examples - icon' }
BlSpaceExamplesMigratedTest >> iconStencil [
	<sampleInstance>
	| aStencil |
	aStencil := BlSpaceIconDummyStencil new.
	aStencil block: [ self iconElement ].
	^ aStencil
]

{ #category : #'examples - time' }
BlSpaceExamplesMigratedTest >> spaceWithSlownDownTimeAndAnimatedElement [

	<simpleInstance>
	| aSpace |
	aSpace := self spaceWithSlownDownTime.
	aSpace root addChild: self animatedElement.

	^ aSpace
]

{ #category : #'examples - icon' }
BlSpaceExamplesMigratedTest >> testChangeIcon [

	<simpleInstance>
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

{ #category : #'instance creation' }
BlSpaceExamplesMigratedTest >> testEmptySpace [

	<simpleInstance>
	| aSpace |
	aSpace := BlOSpace new.
	self assert: aSpace session equals: Smalltalk session.
	self assert: aSpace root hasChildren not.
	self deny: aSpace hasDirtyElements.
	self assert: aSpace extent equals: aSpace defaultExtent.
	self assert: aSpace height equals: aSpace defaultExtent y.
	self assert: aSpace width equals: aSpace defaultExtent x.
	self assert: aSpace position equals: 0 @ 0.
	self assert: aSpace resizable.
	self assert: aSpace borderless not.
	self assert: aSpace fullscreen not.
	self assert: aSpace focused not.
	self assert: aSpace hasHostSpace not.
	self deny: aSpace hasDirtyElements.
	self assert: aSpace hasLayoutError not.
	self assert: aSpace isLayoutRequested.
	self assert: aSpace isVisible not.
	self assert: aSpace title isEmpty.
	self assert: aSpace icon isNil.

	^ aSpace
]

{ #category : #lifecycle }
BlSpaceExamplesMigratedTest >> testFirstPulse [

	<simpleInstance>
	| aSpace |
	aSpace := self testEmptySpace.
	aSpace pulse.

	self deny: aSpace hasDirtyElements.
	self assert: aSpace root position equals: 0 @ 0.
	self assert: aSpace root extent equals: aSpace extent.

	^ aSpace
]

{ #category : #'private - instance creation' }
BlSpaceExamplesMigratedTest >> testInfiniteAnimation [
	<sampleInstance>
	| anAnimation |

	anAnimation := BlSequentialAnimation new.
	anAnimation add: (BlTransformAnimation scale: 2) absolute.
	anAnimation add: (BlTransformAnimation scale: 0.5) absolute.
	anAnimation beInfinite.
	
	^ anAnimation
]
