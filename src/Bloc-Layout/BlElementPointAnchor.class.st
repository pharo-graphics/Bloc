Class {
	#name : #BlElementPointAnchor,
	#superclass : #BlElementLocationAnchor,
	#instVars : [
		'point'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #accessing }
BlElementPointAnchor >> point [

	^ point
]

{ #category : #accessing }
BlElementPointAnchor >> point: aPoint [

	point := aPoint
]

{ #category : #applying }
BlElementPointAnchor >> valueInBounds: aBounds [

	^ aBounds topLeft + point
]
