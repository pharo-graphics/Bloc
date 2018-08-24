Class {
	#name : #BlCompositeAnimation,
	#superclass : #BlBaseAnimation,
	#instVars : [
		'animations'
	],
	#category : 'Bloc-Animation-Basic'
}

{ #category : #'instance creation' }
BlCompositeAnimation class >> with: aCollectionOfAnimations [
	<return: #BlCompositeAnimation>

	^ self new addAll: aCollectionOfAnimations
]

{ #category : #adding }
BlCompositeAnimation >> add: anAnimation [
	anAnimation parent: self.
	anAnimation time: self time.

	animations add: anAnimation
]

{ #category : #adding }
BlCompositeAnimation >> addAll: animations [
	animations do:[:each| self add: each]
]

{ #category : #'api - accessing' }
BlCompositeAnimation >> animations [
	<return: #Collection of: #BlBaseAnimation>

	^ animations
]

{ #category : #'api - accessing' }
BlCompositeAnimation >> children [
	self 
		deprecated: 'Use animations instead'
		on: 	'4 April 2018' 
		in: 'Pharo-6.0-60539-'.
	^ self animations
]

{ #category : #private }
BlCompositeAnimation >> childrenMaxValue: aBlock default: aValue [
	| max |
	self animations ifEmpty: [ ^ aValue ].
	max := aBlock value: self animations first.
	self animations
		allButFirstDo:
			[ :each | 
			| value |
			value := aBlock value: each.
			max := max max: value ].
	^ max
]

{ #category : #private }
BlCompositeAnimation >> childrenMinValue: aBlock default: aValue [
	| min |
	self animations ifEmpty: [ ^ aValue ].
	min := (aBlock value: self animations first) max: 0 seconds.
	self animations
		allButFirstDo:
			[ :each | 
			| value |
			value := aBlock value: each.
			min := min min: value ].
	^ min
]

{ #category : #adding }
BlCompositeAnimation >> computeDuration [
	self subclassResponsibility 
]

{ #category : #pulse }
BlCompositeAnimation >> doStep [
	self subclassResponsibility
]

{ #category : #api }
BlCompositeAnimation >> inParallelDo: aBlock [
	|anim|
	anim := BlParallelAnimation new.
	aBlock value: anim.
	self add: anim.
]

{ #category : #api }
BlCompositeAnimation >> inSequenceDo: aBlock [
	|anim|
	anim := BlSequentialAnimation new.
	aBlock value: anim.
	self add: anim.
]

{ #category : #initialization }
BlCompositeAnimation >> initialize [
	super initialize.
	animations := OrderedCollection new.
	
]

{ #category : #pulse }
BlCompositeAnimation >> stop [
	super stop.

	self stopChildren
]

{ #category : #pulse }
BlCompositeAnimation >> stopChildren [
	animations
		select: [ :anAnimation | anAnimation isRunning ]
		thenDo: [ :anAnimation | anAnimation stop ]
]

{ #category : #accessing }
BlCompositeAnimation >> time: aBlTime [
	super time: aBlTime.
	
	self animations do: [ :anAnimation | anAnimation time: aBlTime ]
]
