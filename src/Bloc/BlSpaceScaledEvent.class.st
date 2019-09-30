"
I am sent by a windowing system when a resolution of the window changes
"
Class {
	#name : #BlSpaceScaledEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlSpaceScaledEvent >> sendTo: anObject [
	anObject spaceScaled: self
]
