"
I'm a `BlScrollFlinger` step.
"
Class {
	#name : #BlSplineOverScrollerStep,
	#superclass : #Object,
	#classInstVars : [
		'spline',
		'cubic',
		'ballistic'
	],
	#category : #'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #accessing }
BlSplineOverScrollerStep class >> ballistic [

	^ ballistic ifNil: [ ballistic := BlSplineOverScrollerBallisticStep new ]
]

{ #category : #cleanup }
BlSplineOverScrollerStep class >> cleanUp [

	super cleanUp.

	ballistic := nil.
	cubic := nil.
	spline := nil
]

{ #category : #accessing }
BlSplineOverScrollerStep class >> cubic [

	^ cubic ifNil: [ cubic := BlSplineOverScrollerCubicStep new ]
]

{ #category : #accessing }
BlSplineOverScrollerStep class >> spline [

	^ spline ifNil: [ spline := BlSplineOverScrollerSplineStep new ]
]

{ #category : #comparing }
BlSplineOverScrollerStep >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
BlSplineOverScrollerStep >> hash [

	^ self class hash
]

{ #category : #hooks }
BlSplineOverScrollerStep >> onFinished: aSplineOverScroller [
	"Is sent after animation duration is reached. It does not necessarily mean that scrolling should stop,
	for example if we overshoot the target we should to bounce back.
	Return true if animation should continue, false otherwise"
	
	^ self subclassResponsibility
]
