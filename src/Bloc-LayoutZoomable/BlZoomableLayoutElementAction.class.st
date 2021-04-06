Class {
	#name : #BlZoomableLayoutElementAction,
	#superclass : #BlLayoutNodeElementAction,
	#instVars : [
		'animationDuration'
	],
	#category : #'Bloc-LayoutZoomable'
}

{ #category : #accessing }
BlZoomableLayoutElementAction >> animationDuration [
	^ animationDuration
]

{ #category : #accessing }
BlZoomableLayoutElementAction >> animationDuration: aDuration [
	animationDuration := aDuration asDuration
]

{ #category : #initialization }
BlZoomableLayoutElementAction >> initialize [
	super initialize.

	animationDuration := 0 milliSeconds
]

{ #category : #evaluating }
BlZoomableLayoutElementAction >> measured: aChildNode element: anElement [
	aChildNode constraints zoomable isDirty
		ifTrue: [
			animationDuration isZero
				ifTrue: [ anElement transformDo: [ :t | t scaleBy: aChildNode constraints zoomable scaleFactor ] ]
				ifFalse: [ anElement addAnimation: ((BlTransformAnimation scale: aChildNode constraints zoomable scaleFactor) absolute duration: self animationDuration) ] ].
	aChildNode constraints zoomable isDirty: false
]
