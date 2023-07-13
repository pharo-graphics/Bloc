"
I contain example of how to use space
"
Class {
	#name : #BlSpaceExamplesMigrated,
	#superclass : #Object,
	#category : #'Bloc-Examples-SpaceMigrated'
}

{ #category : #script }
BlSpaceExamplesMigrated class >> slownDownSpace [
	<script: 'self slownDownSpace'>
	
	self new spaceWithSlownDownTimeAndAnimatedElement
		extent: 350@350;
		show
]

{ #category : #'private - instance creation' }
BlSpaceExamplesMigrated >> animatedElement [
	<gtExample>
	
	^ BlElement new
		background: Color blue;
		size: 150@150;
		position: 100@100;
		addAnimation: self infiniteAnimation
]

{ #category : #'examples - icon' }
BlSpaceExamplesMigrated >> changeIcon [
	<gtExample>
	| aSpace aCollection |
	aSpace := self emptySpace.
	
	aCollection := OrderedCollection new.
	aSpace 
		when: BlSpaceIconChangedEvent 
		do: [ :anEvent | aCollection add: anEvent ].
	
	aSpace icon: self iconStencil.
	
	self assert: aCollection size equals: 1.
	self assert: aCollection first class equals: BlSpaceIconChangedEvent.
	self assert: aCollection first iconStencil class equals: BlSpaceIconDummyStencil.
	
	aSpace icon: aSpace icon.
	self assert: aCollection size equals: 1.
	
	^ aSpace
]

{ #category : #'instance creation' }
BlSpaceExamplesMigrated >> emptySpace [
	<gtExample>
	| aSpace |
	
	aSpace := BlOSpace new.
	self assert: aSpace session equals: Smalltalk session.
	self assert: aSpace root hasChildren not.
	self assert: aSpace dirtyAreas isEmpty.
	self assert: aSpace extent equals: aSpace defaultExtent.
	self assert: aSpace height equals: aSpace defaultExtent y.
	self assert: aSpace width equals: aSpace defaultExtent x.
	self assert: aSpace position equals: 0@0.
	self assert: aSpace resizable.
	self assert: aSpace borderless not.
	self assert: aSpace fullscreen not.
	self assert: aSpace focused not.
	self assert: aSpace hasHostSpace not.
	self assert: aSpace hasDirtyAreas not.
	self assert: aSpace hasLayoutError not.
	self assert: aSpace isLayoutRequested.
	self assert: aSpace isVisible not.
	self assert: aSpace title isEmpty.
	self assert: aSpace icon isNil.

	^ aSpace
]

{ #category : #lifecycle }
BlSpaceExamplesMigrated >> firstPulse [
	<gtExample>
	| aSpace |
	
	aSpace := self emptySpace.
	aSpace pulse.
	
	self assert: aSpace dirtyAreas isEmpty.
	self assert: aSpace root position equals: 0@0.
	self assert: aSpace root extent equals: aSpace extent.

	^ aSpace
]

{ #category : #'examples - icon' }
BlSpaceExamplesMigrated >> iconElement [
	<sampleInstance>
	^ BlElement new
		size: 16@16;
		background: (Color green alpha: 0.5);
		geometry: BlCircleGeometry new.
]

{ #category : #'examples - icon' }
BlSpaceExamplesMigrated >> iconStencil [
	<sampleInstance>
	| aStencil |
	aStencil := BlSpaceIconDummyStencil new.
	aStencil block: [ self iconElement ].
	^ aStencil
]

{ #category : #'private - instance creation' }
BlSpaceExamplesMigrated >> infiniteAnimation [
	<sampleInstance>
	| anAnimation |

	anAnimation := BlSequentialAnimation new.
	anAnimation add: (BlTransformAnimation scale: 2) absolute.
	anAnimation add: (BlTransformAnimation scale: 0.5) absolute.
	anAnimation beInfinite.
	
	^ anAnimation
]

{ #category : #'examples - time' }
BlSpaceExamplesMigrated >> spaceWithSlownDownTimeAndAnimatedElement [
	<gtExample>
	| aSpace |

	aSpace := self spaceWithSlownDownTime.
	aSpace root addChild: self animatedElement.

	^ aSpace
]
