Class {
	#name : #BlAnchorLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #'anchor creation' }
BlAnchorLayoutConstraintsVertical >> breadthAnchor [

	^ BlElementHeightAnchor new
]

{ #category : #'anchor creation' }
BlAnchorLayoutConstraintsVertical >> centerAnchor [

	^ BlElementVerticalCenterAnchor new
]
