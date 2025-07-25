Class {
	#name : #BlElementPointAnchor,
	#superclass : #BlElementLocationAnchor,
	#instVars : [
		'point'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementPointAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| pt |
	pt := aValue - aRectangle extent.
	^ BlBounds
		  origin: pt
		  extent: aRectangle extent
]

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
