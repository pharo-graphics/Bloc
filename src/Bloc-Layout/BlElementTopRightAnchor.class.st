Class {
	#name : #BlElementTopRightAnchor,
	#superclass : #BlElementLocationAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementTopRightAnchor >> valueInBounds: aBounds [

	^ aBounds topRight
]
