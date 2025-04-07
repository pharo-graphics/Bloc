Class {
	#name : #BlCompositeAnimation,
	#superclass : #BlBaseAnimation,
	#instVars : [
		'animations'
	],
	#category : #'Bloc-Animation-Basic'
}

{ #category : #'instance creation' }
BlCompositeAnimation class >> with: anAnimation with: anotherAnimation [

	^ self new
		add: anAnimation;
		add: anotherAnimation;
		yourself
]

{ #category : #'instance creation' }
BlCompositeAnimation class >> withAll: aCollectionOfAnimations [

	^ self new
		  addAll: aCollectionOfAnimations;
		  yourself
]

{ #category : #adding }
BlCompositeAnimation >> add: anAnimation [

	anAnimation parent: self.
	anAnimation time: time.

	animations add: anAnimation
]

{ #category : #adding }
BlCompositeAnimation >> addAll: theAnimations [

	theAnimations do: [ :anAnimation | self add: anAnimation ]
]

{ #category : #'api - accessing' }
BlCompositeAnimation >> animations [

	^ animations
]

{ #category : #initialization }
BlCompositeAnimation >> initialize [

	super initialize.

	animations := OrderedCollection new
]

{ #category : #'api - running' }
BlCompositeAnimation >> stop [

	super stop.

	self stopChildren
]

{ #category : #'api - running' }
BlCompositeAnimation >> stopChildren [

	animations
		select: [ :anAnimation | anAnimation isRunning ]
		thenDo: [ :anAnimation | anAnimation stop ]
]

{ #category : #accessing }
BlCompositeAnimation >> time: aBlTime [

	super time: aBlTime.

	animations do: [ :anAnimation | anAnimation time: aBlTime ]
]
