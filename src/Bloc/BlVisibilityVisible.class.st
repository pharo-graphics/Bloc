"
I am a concrete visibility type - ""visible"".
Once set, element should be rendered and should participate in layout and take space.

"
Class {
	#name : #BlVisibilityVisible,
	#superclass : #BlVisibility,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #testing }
BlVisibilityVisible >> isVisible [
	^ true
]
