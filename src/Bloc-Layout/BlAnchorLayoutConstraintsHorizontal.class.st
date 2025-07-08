Class {
	#name : #BlAnchorLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #'anchor creation' }
BlAnchorLayoutConstraintsHorizontal >> breadthAnchor [

	^ BlElementWidthAnchor new
]

{ #category : #'anchor creation' }
BlAnchorLayoutConstraintsHorizontal >> centerAnchor [

	^ BlElementHorizontalCenterAnchor new
]
