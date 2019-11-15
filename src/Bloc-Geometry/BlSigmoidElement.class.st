Class {
	#name : #BlSigmoidElement,
	#superclass : #BlCurveElement,
	#category : #'Bloc-Geometry-Curves'
}

{ #category : #'anchor - geometry' }
BlSigmoidElement >> fromDirection [
	"Return a vector representing a direction in which start of the curve is pointing"
	<return: #BlVector>

	^ (self fromPosition - self toPosition) asBlocVector
]

{ #category : #layout }
BlSigmoidElement >> layoutBounds [
	| anOrigin aCorner |
	<return: #Rectangle>	

	anOrigin := self fromPosition.
	aCorner := self toPosition.

	^ Rectangle encompassing: { anOrigin. aCorner }
]

{ #category : #layout }
BlSigmoidElement >> measureGeometry [
	| aDecoratedFromPoint aDecoratedToPoint aDelta |

	aDecoratedFromPoint := self decoratedFromPosition.
	aDecoratedToPoint := self decoratedToPosition.

	aDelta := self fromPosition min: self toPosition.
	
	self geometry from: aDecoratedFromPoint - aDelta to: aDecoratedToPoint - aDelta
]

{ #category : #'anchor - geometry' }
BlSigmoidElement >> toDirection [
	"Return a vector representing a direction in which the end of the curve is pointing"
	<return: #BlVector>

	^ (self toPosition - self fromPosition) asBlocVector
]
