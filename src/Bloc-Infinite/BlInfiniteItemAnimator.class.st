"
I am an infinite item animator.

I am responsible for keeping track of item's animation. In case of infinite elements we need to end animation as soon as item goes away and in some cases depending on configuration start on-appear animation when item comes in.

Public API and Key Messages

- endAnimation: ends animation of provided item.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #BlInfiniteItemAnimator,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher',
		'addDuration',
		'removeDuration',
		'moveDuration',
		'changeDuration'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : 'Bloc-Infinite-Animator'
}

{ #category : #accessing }
BlInfiniteItemAnimator >> addDuration [
	"Return duration in ms of item add animation"
	<return: #Number>

	^ addDuration
]

{ #category : #accessing }
BlInfiniteItemAnimator >> addDuration: aNumber [
	"Set the duration for which all add animations will run"

	addDuration := aNumber
]

{ #category : #animations }
BlInfiniteItemAnimator >> animateAppearance: anElementHolder preLayoutInfo: aPreLayoutInfo postLayoutInfo: aPostLayoutInfo [
	self subclassResponsibility
]

{ #category : #animations }
BlInfiniteItemAnimator >> animateChange: anElementHolder previousHolder: anOldElementHolder preLayoutInfo: aPreLayoutInfo postLayoutInfo: aPostLayoutInfo [
	self subclassResponsibility
]

{ #category : #animations }
BlInfiniteItemAnimator >> animateDisappearance: anElementHolder preLayoutInfo: aPreLayoutInfo postLayoutInfo: aPostLayoutInfo [
	self subclassResponsibility
]

{ #category : #animations }
BlInfiniteItemAnimator >> animatePersistence: anElementHolder preLayoutInfo: aPreLayoutInfo postLayoutInfo: aPostLayoutInfo [
	self subclassResponsibility
]

{ #category : #'instance creation' }
BlInfiniteItemAnimator >> buildDataSourceChangeFlagsForAnimations: anElementHolder [
	
	| theFlags |
	
	anElementHolder isInvalid
		ifTrue: [ ^ BlInfiniteItemAnimatorFlags new addInvalidated ].
	
	theFlags := (BlInfiniteItemAnimatorFlags fromFlags: anElementHolder flags)
		and: [ BlInfiniteItemAnimatorFlags new addInvalidated; addRemoved; addChanged; value ].
		
	theFlags hasInvalidated
		ifFalse: [ 
			| anOldPosition aNewPosition |
			anOldPosition := anElementHolder previousPosition.
			aNewPosition := anElementHolder dataSourcePosition.
			(anOldPosition ~= NoPosition and: [
				aNewPosition ~= NoPosition and: [ 
					anOldPosition ~= aNewPosition ] ])
				ifTrue: [ theFlags addMoved ] ].

	^ theFlags
]

{ #category : #testing }
BlInfiniteItemAnimator >> canReuseUpdatedElementHolder: anElementHolder [
	^ true
]

{ #category : #testing }
BlInfiniteItemAnimator >> canReuseUpdatedElementHolder: anElementHolder payloads: aCollectionOfPayloads [
	^ self canReuseUpdatedElementHolder: anElementHolder
]

{ #category : #accessing }
BlInfiniteItemAnimator >> changeDuration [
	"Return duration in ms of item change animation"
	<return: #Number>

	^ changeDuration
]

{ #category : #accessing }
BlInfiniteItemAnimator >> changeDuration: aNumber [
	"Set the duration for which all change animations will run"

	changeDuration := aNumber
]

{ #category : #initialization }
BlInfiniteItemAnimator >> createItemHolder [
	^ BlInfiniteItemInfoHolder new
]

{ #category : #animations }
BlInfiniteItemAnimator >> endAnimation: anElementHolder [
	self subclassResponsibility
]

{ #category : #animations }
BlInfiniteItemAnimator >> endAnimations [
	self subclassResponsibility
]

{ #category : #'event management accessing' }
BlInfiniteItemAnimator >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
BlInfiniteItemAnimator >> initialize [
	super initialize.
	
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #animations }
BlInfiniteItemAnimator >> isRunning [
	<return: #Boolean>
	self subclassResponsibility
]

{ #category : #accessing }
BlInfiniteItemAnimator >> moveDuration [
	"Return duration in ms of item move animation"
	<return: #Number>

	^ moveDuration
]

{ #category : #accessing }
BlInfiniteItemAnimator >> moveDuration: aNumber [
	"Set the duration for which all move animations will run"

	moveDuration := aNumber
]

{ #category : #notifying }
BlInfiniteItemAnimator >> notifyAnimationFinished: anElementHolder [
	self shouldBeImplemented
]

{ #category : #notifying }
BlInfiniteItemAnimator >> notifyAnimationStarted: anElementHolder [
	self shouldBeImplemented
]

{ #category : #notifying }
BlInfiniteItemAnimator >> notifyAnimationsFinished [
	"I notify any listeners that all pending and active item animations are finished"
	self shouldBeImplemented
]

{ #category : #hooks }
BlInfiniteItemAnimator >> onAnimationFinished: anElementHolder [
]

{ #category : #hooks }
BlInfiniteItemAnimator >> onAnimationStarted: anElementHolder [
]

{ #category : #layout }
BlInfiniteItemAnimator >> recordPostLayoutInformation: anInfiniteState holder: anElementHolder [
	
	^ self createItemHolder initializeWith: anElementHolder
]

{ #category : #layout }
BlInfiniteItemAnimator >> recordPreLayoutInformation: anInfiniteState holder: anElementHolder flags: aCollectionOfFlags payloads: aCollectionOfPayloads [

	^ self createItemHolder initializeWith: anElementHolder
]

{ #category : #accessing }
BlInfiniteItemAnimator >> removeDuration [
	"Return duration in ms of item remove animation"
	<return: #Number>

	^ removeDuration
]

{ #category : #accessing }
BlInfiniteItemAnimator >> removeDuration: aNumber [
	"Set the duration for which all remove animations will run"

	removeDuration := aNumber
]

{ #category : #animations }
BlInfiniteItemAnimator >> runPendingAnimations [
	self subclassResponsibility
]

{ #category : #testing }
BlInfiniteItemAnimator >> supportsAnimations [
	"Return true if I am capable of view animations, false otherwise"
	<return: #Boolean>

	^ false
]
