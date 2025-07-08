Class {
	#name : #BlElementBottomRightAnchor,
	#superclass : #BlElementLocationAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementBottomRightAnchor >> valueInBounds: aBounds [

	^ aBounds bottomRight
]
