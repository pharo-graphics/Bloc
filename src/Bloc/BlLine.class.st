"
I define a geometry of a straight line

"
Class {
	#name : #BlLine,
	#superclass : #BlLineGeometry,
	#category : 'Bloc-Basic-Geometry-Deprecated'
}

{ #category : #testing }
BlLine class >> isDeprecated [
	^ true
]

{ #category : #accessing }
BlLine >> intersectionWith: anotherSegment [
	"Copied from LineSegment>>intersectionWith:"
	| det deltaPt alpha beta pt1Dir pt2Dir |
	pt1Dir := to - from.
	pt2Dir := anotherSegment to - anotherSegment from.
	det := (pt1Dir x * pt2Dir y) - (pt1Dir y * pt2Dir x).
	deltaPt := anotherSegment from - from.
	alpha := (deltaPt x * pt2Dir y) - (deltaPt y * pt2Dir x).
	beta := (deltaPt x * pt1Dir y) - (deltaPt y * pt1Dir x).
	det = 0 ifTrue:[^nil]. "no intersection"
	alpha * det < 0 ifTrue:[^nil].
	beta * det < 0 ifTrue:[^nil].
	det > 0 
		ifTrue:[(alpha > det or:[beta > det]) ifTrue:[^nil]]
		ifFalse:[(alpha < det or:[beta < det]) ifTrue:[^nil]].
	"And compute intersection"
	^from + (alpha * pt1Dir / (det@det))
]
