"
I am a super class of all window related events fired by morphic host window
"
Class {
	#name : #BlMorphicWindowEvent,
	#superclass : #WindowEvent,
	#category : #'BlocHost-Morphic7-Events'
}

{ #category : #accessing }
BlMorphicWindowEvent >> type [
	^ #window
]
