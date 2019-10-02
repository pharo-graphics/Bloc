Class {
	#name : #BlHostSize,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'width',
		'height'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlHostSize class >> width: aWidth height: aHeight [
	^ self new initializeWidth: aWidth height: aHeight
]

{ #category : #accessing }
BlHostSize >> height [
	<return: #Number>

	^ height
]

{ #category : #initialization }
BlHostSize >> initializeWidth: aWidth height: aHeight [
	width := aWidth.
	height := aHeight
]

{ #category : #testing }
BlHostSize >> isZero [
	<return: #Boolean>
	
	^ self width isZero or: [ self height isZero ]
]

{ #category : #accessing }
BlHostSize >> width [
	<return: #Number>

	^ width
]
