Class {
	#name : #BlElementPerimeterAnchor,
	#superclass : #BlElementLocationAnchor,
	#instVars : [
		'radians'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementPerimeterAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y pt |
	pt := self valueInBounds: aRectangle.
	x := aValue x - (aRectangle width / 2).
	y := aValue y  - (aRectangle height / 2).
	^ BlBounds
		  origin: x @ y
		  extent: aRectangle extent
]

{ #category : #accessing }
BlElementPerimeterAnchor >> degrees [

	^ radians / Float pi * 180
]

{ #category : #accessing }
BlElementPerimeterAnchor >> degrees: anAngleInDegrees [

	radians := anAngleInDegrees degreesToRadians 
]

{ #category : #accessing }
BlElementPerimeterAnchor >> radians [

	^ radians 
]

{ #category : #accessing }
BlElementPerimeterAnchor >> radians: anAngleInRadians [

	radians := anAngleInRadians
]

{ #category : #applying }
BlElementPerimeterAnchor >> valueInBounds: aBounds [

	^ (self element geometry pointOnPerimeterForAnchor: self)
	  + aBounds topLeft
]
