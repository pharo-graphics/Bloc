Class {
	#name : #BlTriangleGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'orientation'
	],
	#classVars : [
		'Bottom',
		'Left',
		'Right',
		'Top'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'class initialization' }
BlTriangleGeometry class >> initialize [
	Top := #top.
	Right := #right.
	Bottom := #bottom.
	Left := #left
]

{ #category : #comparing }
BlTriangleGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ (self isBottom and: [ anObject isBottom ]) or: [
		  (self isLeft and: [ anObject isLeft ]) or: [
			  (self isRight and: [ anObject isRight ]) or: [
				  self isTop and: [ anObject isTop ] ] ] ].
]

{ #category : #'api - geometry' }
BlTriangleGeometry >> beBottom [
	orientation := Bottom.
	self releaseCache
]

{ #category : #'api - geometry' }
BlTriangleGeometry >> beLeft [
	orientation := Left.
	self releaseCache
]

{ #category : #'api - geometry' }
BlTriangleGeometry >> beRight [
	orientation := Right.
	self releaseCache
]

{ #category : #'api - geometry' }
BlTriangleGeometry >> beTop [
	orientation := Top.
	self releaseCache
]

{ #category : #'private - geometry' }
BlTriangleGeometry >> computeBottomVertices [
	| aHeight aWidth aHalfWidth |
	
	aHeight := self extent y.
	aWidth := self extent x.
	aHalfWidth := aWidth / 2.0.
	
	^ { 
		0 @ 0.
		aWidth @ 0.
		aHalfWidth @ aHeight.
	}
]

{ #category : #'private - geometry' }
BlTriangleGeometry >> computeLeftVertices [
	| aHeight aWidth aHalfHeight |
	
	aHeight := self extent y.
	aWidth := self extent x.
	aHalfHeight := aHeight / 2.0.

	^ { 
		aWidth @ 0.
		aWidth @ aHeight.
		0 @ aHalfHeight.
	}
]

{ #category : #'private - geometry' }
BlTriangleGeometry >> computeRightVertices [
	| aHeight aWidth aHalfHeight |
	
	aHeight := self extent y.
	aWidth := self extent x.
	aHalfHeight := aHeight / 2.0.

	^ { 
		0 @ 0.
		aWidth @ aHalfHeight.
		0 @ aHeight.
	}
]

{ #category : #'private - geometry' }
BlTriangleGeometry >> computeTopVertices [
	| aHeight aWidth aHalfWidth |
	
	aHeight := self extent y.
	aWidth := self extent x.
	aHalfWidth := aWidth / 2.0.
	
	^ { 
		0 @ aHeight.
		aHalfWidth @ 0.
		aWidth @ aHeight.
	}
]

{ #category : #'private - geometry' }
BlTriangleGeometry >> computeVertices [
	^ self isTop
		ifTrue: [ self computeTopVertices ]
		ifFalse: [
			self isRight
				ifTrue: [ self computeRightVertices ]
				ifFalse: [
					self isBottom
						ifTrue: [ self computeBottomVertices ]
						ifFalse: [
							self isLeft
								ifTrue: [ self computeLeftVertices ]
								ifFalse: [ self error: ('Triangle has unsupported orientation ({1})' format: { orientation }) ] ] ] ]
]

{ #category : #'geometry testing' }
BlTriangleGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [

	^ BlPolygonHitTester doPolygonBy: self computeVertices include: aPoint
]

{ #category : #testing }
BlTriangleGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlTriangleGeometry >> hasJoins [

	^ true
]

{ #category : #initialization }
BlTriangleGeometry >> initialize [
	super initialize.
	
	orientation := Right.
]

{ #category : #testing }
BlTriangleGeometry >> isBottom [
	^ orientation = Bottom
]

{ #category : #testing }
BlTriangleGeometry >> isLeft [
	^ orientation = Left
]

{ #category : #testing }
BlTriangleGeometry >> isRight [
	^ orientation = Right
]

{ #category : #testing }
BlTriangleGeometry >> isTop [
	^ orientation = Top
]

{ #category : #geometry }
BlTriangleGeometry >> matchExtent: aPoint [
	extent := aPoint
]
