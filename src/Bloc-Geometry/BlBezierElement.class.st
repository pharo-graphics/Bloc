"
I represent a curve element that is rendered between two provided anchors via additional control anchors.

See ${class:BlBezierElementExamples}$.
"
Class {
	#name : #BlBezierElement,
	#superclass : #BlCurveElement,
	#instVars : [
		'viaAnchors'
	],
	#category : #'Bloc-Geometry-Curves'
}

{ #category : #'anchor - geometry' }
BlBezierElement >> anchorPositions [
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self fromPosition.
		viaAnchors do: [ :anAnchor |
			aStream nextPut: (anAnchor positionWithin: self) ].
		aStream nextPut: self toPosition ]
]

{ #category : #'anchor - geometry' }
BlBezierElement >> decoratedAnchorPositions [
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self decoratedFromPosition.
		viaAnchors do: [ :anAnchor |
			aStream nextPut: (anAnchor positionWithin: self) ].
		aStream nextPut: self decoratedToPosition ]
]

{ #category : #initialization }
BlBezierElement >> defaultGeometry [
	^ BlBezierCurve new
]

{ #category : #'instance creation' }
BlBezierElement >> fromDirection [
	"Return a vector representing a direction in which start of the curve is pointing"
	<return: #BlVector>
	| thePositions |	
	thePositions := self anchorPositions.

	^ (thePositions first - thePositions second) asBlocVector
]

{ #category : #initialization }
BlBezierElement >> initialize [
	super initialize.

	viaAnchors := OrderedCollection new
]

{ #category : #layout }
BlBezierElement >> layoutBounds [
	<return: #Rectangle>
	
	^ Rectangle encompassing: self anchorPositions
]

{ #category : #layout }
BlBezierElement >> measureGeometry [
	| theAnchorPositions aDelta |
	
	theAnchorPositions := self decoratedAnchorPositions.
	aDelta := self layoutBounds origin.

	self geometry controlPoints: (theAnchorPositions collect: [ :aPoint | aPoint - aDelta ])
]

{ #category : #'instance creation' }
BlBezierElement >> toDirection [
	"Return a vector representing a direction in which the end of the curve is pointing"
	<return: #BlVector>
	| thePositions |	
	thePositions := self anchorPositions.

	^ (thePositions last - (thePositions at: thePositions size - 1)) asBlocVector
]

{ #category : #'anchor - accessing' }
BlBezierElement >> viaAnchor: aBlGeometryAnchor [
	"Add one more anchor between `from` and `to`".
	
	viaAnchors add: aBlGeometryAnchor.
	self registerAnchor: aBlGeometryAnchor
]
