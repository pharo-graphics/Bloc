Class {
	#name : #BlElementTopLeftAnchor,
	#superclass : #BlElementLocationAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementTopLeftAnchor >> valueInBounds: aBounds [

	^ aBounds topLeft
]
