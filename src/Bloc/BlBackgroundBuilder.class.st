Class {
	#name : #BlBackgroundBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'opacity'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #building }
BlBackgroundBuilder >> build [
	<return: #BlBackground>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlBackgroundBuilder >> initialize [
	super initialize.
	
	opacity := 1.0
]

{ #category : #building }
BlBackgroundBuilder >> isOpaque [
	<return: #Boolean>

	^ self opacity closeTo: 1
]

{ #category : #accessing }
BlBackgroundBuilder >> opacity [
	<return: #Number>

	^ opacity
]

{ #category : #accessing }
BlBackgroundBuilder >> opacity: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Opacity must not be nil' ].
	self
		assert: [ aNumber between: 0.0 and: 1.0 ]
		description: [ 'Opacity value must be within interval [0..1]' ].

	opacity := aNumber
]
