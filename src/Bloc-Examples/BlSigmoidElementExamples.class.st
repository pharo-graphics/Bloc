Class {
	#name : #BlSigmoidElementExamples,
	#superclass : #BlGeometryElementExamples,
	#category : #'Bloc-Examples-Geometry'
}

{ #category : #'examples - instance creation' }
BlSigmoidElementExamples >> newSigmoid [
	<gtExample>
	
	^ BlSigmoidElement new
		zIndex: 10;
		border: (BlBorder paint: Color red width: 4);
		yourself
]

{ #category : #'examples - bending point' }
BlSigmoidElementExamples >> sigmoidBendingFirstQuarterPoint [
	<gtExample>
	| aSigmoid attachFrom attachTo |
	
	aSigmoid := self newSigmoid.
	aSigmoid bendingPoint: 0.25.
	aSigmoid sharpness: 1.0.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { aSigmoid . attachFrom . attachTo }
]

{ #category : #'examples - bending point' }
BlSigmoidElementExamples >> sigmoidBendingFourthQuarterPoint [
	<gtExample>
	| aSigmoid attachFrom attachTo |
	
	aSigmoid := self newSigmoid.
	aSigmoid bendingPoint: 0.75.
	aSigmoid sharpness: 1.0.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { aSigmoid . attachFrom . attachTo }
]

{ #category : #'examples - bending point' }
BlSigmoidElementExamples >> sigmoidBendingMiddlePoint [
	<gtExample>
	| aSigmoid attachFrom attachTo |
	
	aSigmoid := self newSigmoid.
	aSigmoid bendingPoint: 0.5.
	aSigmoid sharpness: 1.0.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { aSigmoid . attachFrom . attachTo }
]

{ #category : #'examples - sigmoid' }
BlSigmoidElementExamples >> sigmoidDefault [
	<gtExample>	
	| aSigmoid attachFrom attachTo |
	
	aSigmoid := self newSigmoid.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { aSigmoid . attachFrom . attachTo }
]

{ #category : #'examples - sharpness' }
BlSigmoidElementExamples >> sigmoidSharp [
	<gtExample>
	| aSigmoid attachFrom attachTo |

	aSigmoid := self newSigmoid.
	aSigmoid sharpness: 1.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { aSigmoid . attachFrom . attachTo }
]

{ #category : #'examples - sharpness' }
BlSigmoidElementExamples >> sigmoidSmooth [
	<gtExample>
	| aSigmoid attachFrom attachTo |
	
	aSigmoid := self newSigmoid.
	"it degrades to a line"
	aSigmoid sharpness: 0.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { aSigmoid . attachFrom . attachTo }
]

{ #category : #'examples - sharpness' }
BlSigmoidElementExamples >> sigmoidSoft [
	<gtExample>
	| aSigmoid attachFrom attachTo |

	aSigmoid := self newSigmoid.
	aSigmoid sharpness: 0.5.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { aSigmoid . attachFrom . attachTo }
]
