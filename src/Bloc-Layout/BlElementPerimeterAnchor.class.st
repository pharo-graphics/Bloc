Class {
	#name : #BlElementPerimeterAnchor,
	#superclass : #BlElementLocationAnchor,
	#instVars : [
		'radians'
	],
	#category : #'Bloc-Layout-Anchor'
}

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
