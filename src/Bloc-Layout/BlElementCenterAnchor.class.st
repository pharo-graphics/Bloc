Class {
	#name : #BlElementCenterAnchor,
	#superclass : #BlElementLocationAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementCenterAnchor >> valueInBounds: aBounds [

	^ aBounds center
]
