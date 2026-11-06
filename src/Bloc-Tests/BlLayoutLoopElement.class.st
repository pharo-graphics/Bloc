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
