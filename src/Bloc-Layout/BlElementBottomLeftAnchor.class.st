Class {
	#name : #BlElementBottomLeftAnchor,
	#superclass : #BlElementLocationAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementBottomLeftAnchor >> valueInBounds: aBounds [

	^ aBounds bottomLeft
]
