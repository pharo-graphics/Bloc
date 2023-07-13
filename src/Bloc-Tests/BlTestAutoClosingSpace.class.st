"
I am a space that closes itself after a given amount of frames
"
Class {
	#name : #BlTestAutoClosingSpace,
	#superclass : #BlOSpace,
	#instVars : [
		'frames',
		'frameCounter'
	],
	#category : #'Bloc-Tests-Examples'
}

{ #category : #accessing }
BlTestAutoClosingSpace >> frames [
	^ frames
]

{ #category : #accessing }
BlTestAutoClosingSpace >> frames: aNumber [
	frames := aNumber
]

{ #category : #initialization }
BlTestAutoClosingSpace >> initialize [
	super initialize.
	
	frames := 10.
	frameCounter := 0
]

{ #category : #pulse }
BlTestAutoClosingSpace >> pulse [
	super pulse.
	
	frameCounter := frameCounter + 1.
	frameCounter >= frames
		ifTrue: [ self close ].
]
