Class {
	#name : #BlSplineOverScrollerMode,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Utilities - Scrolling Helpers'
}

{ #category : #updating }
BlSplineOverScrollerMode >> continueOn: aSplineOverScroller [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #updating }
BlSplineOverScrollerMode >> finishOn: aSplineOverScroller [
	"Finish animation and finalize scroller state"

	aSplineOverScroller currentPosition: aSplineOverScroller finalPosition.
	aSplineOverScroller currentVelocity: 0.0.
	aSplineOverScroller isFinished: true.
	aSplineOverScroller updateTime: nil.
]

{ #category : #'as yet unclassified' }
BlSplineOverScrollerMode >> gtInspectorGraphIn: aComposite [
	<gtInspectorPresentationOrder: 10>

	^ aComposite bloc
		title: 'Graph';
		when: [ Smalltalk globals hasClassNamed: #GtPlotter ];
		display: [
			| aScroller theData theColors aPlotter |
			
			aScroller := BlOvershootingSplineBasedScroller new.
			aScroller bePrecise.
			aScroller time: (BlTime simulated).
			aScroller mode: self.

			theData := OrderedCollection new.
			aScroller time
				every: 10 milliSeconds
				while: [ aScroller run ]
				do: [ theData add: {
					#time -> aScroller time now.
					#position -> aScroller currentPosition.
					#step -> aScroller currentStep
				} asDictionary ].

			theColors := {
				BlSplineOverScrollerStep spline -> Color red.
				BlSplineOverScrollerStep ballistic -> Color blue.
				BlSplineOverScrollerStep cubic -> Color green muchDarker.
			} asDictionary.

			aPlotter := #GtPlotter asClass new.
			aPlotter line
				y: [ :each | each at: #position ];
				x: [ :each | each at: #time ];
				shape: [ :from :to :line | line border: (BlBorder paint: (theColors at: (to at: #step)) width: 1) ];
				with: theData.

			aPlotter root ]
]

{ #category : #initialization }
BlSplineOverScrollerMode >> initializeOn: aSplineOverScroller [
	self subclassResponsibility
]

{ #category : #updating }
BlSplineOverScrollerMode >> updateOn: aSplineOverScroller [
	<return: #Boolean>

	self subclassResponsibility
]
