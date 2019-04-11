"
I contain examples and a few usecases of ===BlArcElement===
"
Class {
	#name : #BlParabollaExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Examples-Geometry'
}

{ #category : #examples }
BlParabollaExamples class >> absoluteCurvature [
	<script: 'self absoluteCurvature'>

	self
		openInWindow: self new absoluteCurvature
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #examples }
BlParabollaExamples class >> relativeCurvature [
	<script: 'self relativeCurvature'>

	self openInWindow:
		self new relativeCurvature
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #'examples - connections' }
BlParabollaExamples >> absoluteCurvature [
	<gtExample>	
	| redArc attachFrom attachTo perpendicularAttach fromLine toLine connectLine |
	
	attachFrom := self attachPoint relocate: 100 @ 100.
	attachTo := self attachPoint relocate: 300 @ 400.
	
	redArc := self redArc.
	"order does not matter"
	redArc curvature: 50.
	redArc fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redArc toAnchor: (BlElementCenterAnchor element: attachTo).
	
	"------ fancy look ------"
	
	"visual represenation of perpendicular anchor (does not influence the curve)"
	perpendicularAttach := BlEllipseElement radius: 15.
	perpendicularAttach background: (Color red alpha: 0.4).
	perpendicularAttach centerAnchor: redArc curvatureAnchor.
	
	"visual connection between anchors (does not influence the curve)"
	fromLine := self greyLine.
	fromLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	fromLine toAnchor: (BlElementCenterAnchor element: perpendicularAttach).
	
	"visual connection between anchors (does not influence the curve)"
	toLine := self greyLine.
	toLine fromAnchor: (BlElementCenterAnchor element: perpendicularAttach).
	toLine toAnchor: (BlElementCenterAnchor element: attachTo).
	
	"visual connection between anchors (does not influence the curve)"
	connectLine := self greyLine.
	connectLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	connectLine toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { redArc . attachFrom . perpendicularAttach. attachTo . fromLine . toLine . connectLine }
]

{ #category : #'instance creation' }
BlParabollaExamples >> arc [
	<gtExample>
	
	^ BlParabollaArcElement new
		zIndex: 10;
		yourself
]

{ #category : #'instance creation' }
BlParabollaExamples >> attachPoint [
	<gtExample>	

	^ BlElement new
		geometry: BlEllipse new;
		size: 30@30;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlPullHandler new
]

{ #category : #'examples - visual properties' }
BlParabollaExamples >> blueArc [
	<gtExample>

	^ self arc border: (BlBorder paint: Color blue width: 4)
]

{ #category : #'examples - visual properties' }
BlParabollaExamples >> blueArcWithToHead [
	<gtExample>

	^ self blueArc
		toHead: (BlArrowheadSimpleArrow new
			arrowNoseAngle: 60;
			arrowLengthFraction: 5;
			border: (BlBorder paint: Color blue width: 2))
]

{ #category : #'examples - self edges' }
BlParabollaExamples >> bottomCenterToTopCenter [
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementBottomCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementTopCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }
]

{ #category : #'examples - self edges' }
BlParabollaExamples >> bottomToTopBidirectional [
	<gtExample>
	| aCurveDown aCurveUp anElement |
	
	anElement := self referenceElement.
	
	aCurveDown := self blueArcWithToHead.
	aCurveDown fromAnchor: (BlElementTopCenterAnchor element: anElement).
	aCurveDown toAnchor: (BlElementBottomCenterAnchor element: anElement).
	
	aCurveUp := self redArcWithToHead.
	aCurveUp fromAnchor: (BlElementBottomCenterAnchor element: anElement).
	aCurveUp toAnchor: (BlElementTopCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurveDown . aCurveUp }
]

{ #category : #'instance creation' }
BlParabollaExamples >> container [
	<gtExample>
	
	^ BlElement new
		background: Color white;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #'examples - visual properties' }
BlParabollaExamples >> greyLine [
	<gtExample>

	^ self line
		border: (BlBorder builder paint: (Color gray alpha: 0.5); width: 1; build)
]

{ #category : #'examples - self edges' }
BlParabollaExamples >> leftToRightBidirectional [
	<gtExample>
	| aCurveLeft aCurveRight anElement |
	
	anElement := self referenceElement.
	
	aCurveLeft := self redArcWithToHead.
	aCurveLeft fromAnchor: (BlElementCenterRightAnchor element: anElement).
	aCurveLeft toAnchor: (BlElementCenterLeftAnchor element: anElement).
	
	aCurveRight := self blueArcWithToHead.
	aCurveRight fromAnchor: (BlElementCenterLeftAnchor element: anElement).
	aCurveRight toAnchor: (BlElementCenterRightAnchor element: anElement).

	^ self container addChildren: { anElement . aCurveLeft . aCurveRight }
]

{ #category : #'instance creation' }
BlParabollaExamples >> line [
	<gtExample>
	
	^ BlLineElement new
		zIndex: 10;
		yourself
]

{ #category : #'examples - visual properties' }
BlParabollaExamples >> redArc [
	<gtExample>

	^ self arc border: (BlBorder paint: Color red width: 4)
]

{ #category : #'examples - visual properties' }
BlParabollaExamples >> redArcWithToHead [
	<gtExample>

	^ self redArc
		toHead: (BlArrowheadSimpleArrow new
			arrowNoseAngle: 60;
			arrowLengthFraction: 5;
			border: (BlBorder paint: Color red width: 2))
]

{ #category : #'instance creation' }
BlParabollaExamples >> referenceElement [
	<gtExample>
	
	^ BlElement new
		size: 150@150;
		relocate: 200@200;
		background: (Color gray alpha: 0.2)
]

{ #category : #'examples - connections' }
BlParabollaExamples >> relativeCurvature [
	<gtExample>	
	| redArc attachFrom attachTo perpendicularAttach fromLine toLine connectLine |
	
	attachFrom := self attachPoint relocate: 100 @ 100.
	attachTo := self attachPoint relocate: 300 @ 400.
	
	redArc := self redArc.
	"order does not matter"
	redArc curvatureFraction: 0.5.
	redArc fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redArc toAnchor: (BlElementCenterAnchor element: attachTo).
	
	"------ fancy look ------"
	
	"visual represenation of perpendicular anchor (does not influence the curve)"
	perpendicularAttach := BlEllipseElement radius: 15.
	perpendicularAttach background: (Color red alpha: 0.4).
	perpendicularAttach centerAnchor: redArc curvatureAnchor.
	
	"visual connection between anchors (does not influence the curve)"
	fromLine := self greyLine.
	fromLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	fromLine toAnchor: (BlElementCenterAnchor element: perpendicularAttach).
	
	"visual connection between anchors (does not influence the curve)"
	toLine := self greyLine.
	toLine fromAnchor: (BlElementCenterAnchor element: perpendicularAttach).
	toLine toAnchor: (BlElementCenterAnchor element: attachTo).
	
	"visual connection between anchors (does not influence the curve)"
	connectLine := self greyLine.
	connectLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	connectLine toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { redArc . attachFrom . perpendicularAttach. attachTo . fromLine . toLine . connectLine }
]

{ #category : #'examples - connections' }
BlParabollaExamples >> relativeCurvatureWithoutDecorations [
	<gtExample>	
	| redArc attachFrom attachTo |
	
	attachFrom := (self attachPoint opacity: 0.5) relocate: 100 @ 100.
	attachTo := (self attachPoint opacity: 0.5) relocate: 300 @ 400.
	
	redArc := self redArc.
	"order does not matter"
	redArc curvatureFraction: 0.5.
	redArc fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redArc toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { redArc . attachFrom . attachTo }
]

{ #category : #'examples - self edges' }
BlParabollaExamples >> rightCenterToTopCenter [
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementCenterRightAnchor element: anElement).
	aCurve toAnchor: (BlElementTopCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }
]

{ #category : #'examples - self edges' }
BlParabollaExamples >> topCenterToBottomCenter [
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementTopCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementBottomCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }
]

{ #category : #'examples - self edges' }
BlParabollaExamples >> topCenterToRightCenter [
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementTopCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementCenterRightAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }
]
