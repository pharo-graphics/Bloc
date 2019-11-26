"
I represent a line element that is rendered between two provided position or attachment points
"
Class {
	#name : #BlLineElement,
	#superclass : #BlCurveElement,
	#category : #'Bloc-Geometry-Curves'
}

{ #category : #initialization }
BlLineElement >> defaultGeometry [
	^ BlLine new
]

{ #category : #'anchor - geometry' }
BlLineElement >> fromDirection [
	"Return a vector representing a direction in which start of the curve is pointing"
	<return: #BlVector>

	^ (self fromPosition - self toPosition) asBlocVector
]

{ #category : #layout }
BlLineElement >> layoutBounds [
	| anOrigin aCorner |
	<return: #Rectangle>	

	anOrigin := self fromPosition.
	aCorner := self toPosition.

	^ Rectangle encompassing: { anOrigin. aCorner }
]

{ #category : #layout }
BlLineElement >> measureGeometry [
	| aDecoratedFromPoint aDecoratedToPoint aDelta |

	aDecoratedFromPoint := self decoratedFromPosition.
	aDecoratedToPoint := self decoratedToPosition.

	aDelta := self fromPosition min: self toPosition.
	
	self geometry
		from: aDecoratedFromPoint - aDelta
		to: aDecoratedToPoint - aDelta
]

{ #category : #'anchor - geometry' }
BlLineElement >> toDirection [
	"Return a vector representing a direction in which the end of the curve is pointing"
	<return: #BlVector>

	^ (self toPosition - self fromPosition) asBlocVector
]
