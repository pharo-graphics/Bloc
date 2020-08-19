"
I contain example of how to use space
"
Class {
	#name : #BlSpaceExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Examples-Space'
}

{ #category : #'as yet unclassified' }
BlSpaceExamples class >> slownDownSpace [
	<script: 'self slownDownSpace'>
	
	self new spaceWithSlownDownTimeAndAnimatedElement
		extent: 350@350;
		show
]

{ #category : #'private - instance creation' }
BlSpaceExamples >> animatedElement [
	<gtExample>
	
	^ BlElement new
		background: Color blue;
		size: 150@150;
		relocate: 100@100;
		addAnimation: self infiniteAnimation
]

{ #category : #'instance creation' }
BlSpaceExamples >> emptySpace [
	<gtExample>
	| aSpace |
	
	aSpace := BlSpace new.
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

	^ aSpace
]

{ #category : #lifecycle }
BlSpaceExamples >> firstPulse [
	<gtExample>
	| aSpace |
	
	aSpace := self emptySpace.
	aSpace pulse.
	
	self assert: aSpace dirtyAreas isEmpty.
	self assert: aSpace root position equals: 0@0.
	self assert: aSpace root extent equals: aSpace extent.

	^ aSpace
]

{ #category : #'private - instance creation' }
BlSpaceExamples >> infiniteAnimation [
	<gtExample>
	| anAnimation |

	anAnimation := BlSequentialAnimation new.
	anAnimation add: (BlTransformAnimation scale: 2) absolute.
	anAnimation add: (BlTransformAnimation scale: 0.5) absolute.
	anAnimation beInfinite.
	
	^ anAnimation
]

{ #category : #'examples - time' }
BlSpaceExamples >> spaceWithSlownDownTime [
	<gtExample>
	| aTime aSpace |

	aTime := BlFastForwardedTime new.
	aTime speed: 0.2.

	aSpace := BlSpace new.
	aSpace time: aTime.

	^ aSpace
]

{ #category : #'examples - time' }
BlSpaceExamples >> spaceWithSlownDownTimeAndAnimatedElement [
	<gtExample>
	| aSpace |

	aSpace := self spaceWithSlownDownTime.
	aSpace root addChild: self animatedElement.

	^ aSpace
]
