"
A fixture for the tests of the layout loops: each time I am laid out I move my first child, which asks for another layout, until I am told to stop looping.
"
Class {
	#name : #BlLayoutLoopElement,
	#superclass : #BlElement,
	#instVars : [
		'passes',
		'isLooping'
	],
	#category : #'Bloc-Tests-Layout'
}

{ #category : #initialization }
BlLayoutLoopElement >> initialize [

	super initialize.
	passes := 0.
	isLooping := true
]

{ #category : #layout }
BlLayoutLoopElement >> onLayout: aBounds context: aContext [
	"I ask for another layout each time I am laid out, as long as I loop: my child moves by one pixel"

	super onLayout: aBounds context: aContext.
	passes := passes + 1.
	isLooping ifTrue: [ self children first position: passes @ 0 ]
]

{ #category : #accessing }
BlLayoutLoopElement >> passes [

	^ passes
]

{ #category : #accessing }
BlLayoutLoopElement >> stopLooping [

	isLooping := false
]
