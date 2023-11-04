"
I am a super class of all window related events fired by morphic host window
"
Class {
	#name : 'BlMorphicWindowEvent',
	#superclass : 'WindowEvent',
	#category : 'BlocHost-Morphic-Events',
	#package : 'BlocHost-Morphic',
	#tag : 'Events'
}

{ #category : 'accessing' }
BlMorphicWindowEvent >> type [
	^ #window
]
