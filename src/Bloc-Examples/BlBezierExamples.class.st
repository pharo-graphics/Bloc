"
I contain examples and a few usecases of ===BlBezierElement===
"
Class {
	#name : #BlBezierExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : 'Bloc-Examples-Geometry'
}

{ #category : #examples }
BlBezierExamples class >> bezierControlPoints [
	<script: 'self bezierControlPoints'>
	
	self openInWindow:
		self new curveWithAnchors
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #examples }
BlBezierExamples class >> quadraticCurve [
	<script: 'self quadraticCurve'>
	
	self openInWindow:
		self new quadraticCurveWithAnchors
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #examples }
BlBezierExamples class >> quadraticCurveWithPerpendicularAnchor [
	<script: 'self quadraticCurveWithPerpendicularAnchor'>

	self openInWindow:
		self new quadraticCurveWithPerpendicularAnchor
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #examples }
BlBezierExamples class >> quadraticCurveWithPerpendicularFractionAnchor [
	<script: 'self quadraticCurveWithPerpendicularFractionAnchor'>

	self openInWindow:
		self new quadraticCurveWithPerpendicularFractionAnchor
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #'instance creation' }
BlBezierExamples >> attachPoint [
	<gtExample>	

	^ BlElement new
		geometry: BlEllipse new;
		size: 30@30;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlPullHandler new
]

{ #category : #'instance creation' }
BlBezierExamples >> container [
	<gtExample>
	
	^ BlElement new
		background: Color white;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #'instance creation' }
BlBezierExamples >> curve [
	<gtExample>
	
	^ BlBezierElement new
		zIndex: 10;
		yourself
]

{ #category : #'example - connections' }
BlBezierExamples >> curveWithAnchors [
	<gtExample>	
	| redCurve attachFrom attachTo firstViaAttach secondViaAttach fromLine toLine |
	
	redCurve := self redCurve.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 300.

	firstViaAttach := self attachPoint.
	firstViaAttach relocate: 150 @ 100.
	
	secondViaAttach := self attachPoint.
	secondViaAttach relocate: 350 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 400 @ 300.

	fromLine := self greyLine.
	fromLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	fromLine toAnchor: (BlElementCenterAnchor element: firstViaAttach).
	
	toLine := self greyLine.
	toLine fromAnchor: (BlElementCenterAnchor element: secondViaAttach).
	toLine toAnchor: (BlElementCenterAnchor element: attachTo).

	redCurve fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redCurve viaAnchor: (BlElementCenterAnchor element: firstViaAttach).
	redCurve viaAnchor: (BlElementCenterAnchor element: secondViaAttach).
	redCurve toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { redCurve . attachFrom . firstViaAttach. secondViaAttach . attachTo . fromLine . toLine }
]

{ #category : #'example - visual properties' }
BlBezierExamples >> greyLine [
	<gtExample>

	^ self line
		border: (BlBorder builder paint: (Color gray alpha: 0.5); width: 1; build)
]

{ #category : #'instance creation' }
BlBezierExamples >> line [
	<gtExample>
	
	^ BlLineElement new
		zIndex: 10;
		yourself
]

{ #category : #'example - connections' }
BlBezierExamples >> quadraticCurveWithAnchors [
	<gtExample>	
	| redCurve attachFrom attachTo viaAttach fromLine toLine |
	
	redCurve := self redCurve.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 300.

	viaAttach := self attachPoint.
	viaAttach relocate: 250 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 400 @ 300.

	fromLine := self greyLine.
	fromLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	fromLine toAnchor: (BlElementCenterAnchor element: viaAttach).
	
	toLine := self greyLine.
	toLine fromAnchor: (BlElementCenterAnchor element: viaAttach).
	toLine toAnchor: (BlElementCenterAnchor element: attachTo).

	redCurve fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redCurve viaAnchor: (BlElementCenterAnchor element: viaAttach).
	redCurve toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { redCurve . attachFrom . viaAttach. attachTo . fromLine . toLine }
]

{ #category : #'example - connections' }
BlBezierExamples >> quadraticCurveWithPerpendicularAnchor [
	<gtExample>	
	| redCurve attachFrom attachTo anchorFrom anchorTo perpendicularAnchor perpendicularAttach fromLine toLine connectLine |
	
	redCurve := self redCurve.
	
	attachFrom := self attachPoint relocate: 100 @ 100.
	attachTo := self attachPoint relocate: 300 @ 400.

	anchorFrom := BlElementCenterAnchor element: attachFrom.	
	anchorTo := BlElementCenterAnchor element: attachTo.
	
	perpendicularAnchor := BlPerpendicularAnchor new.
	"order of the reference anchors matters"
	perpendicularAnchor referenceAnchors: { anchorFrom . anchorTo }.
	"the length of a perpendicular is half of the distance"
	perpendicularAnchor curvature: 100.

	redCurve fromAnchor: anchorFrom.
	redCurve toAnchor: anchorTo.
	redCurve viaAnchor: perpendicularAnchor.
	
	"------ fancy look ------"
	
	"visual represenation of perpendicular anchor (does not influence the curve)"
	perpendicularAttach := BlEllipseElement radius: 15.
	perpendicularAttach background: (Color red alpha: 0.4).
	perpendicularAttach centerAnchor: perpendicularAnchor.
	
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
		addChildren: { redCurve . attachFrom . perpendicularAttach. attachTo . fromLine . toLine . connectLine }
]

{ #category : #'example - connections' }
BlBezierExamples >> quadraticCurveWithPerpendicularFractionAnchor [
	<gtExample>	
	| redCurve attachFrom attachTo anchorFrom anchorTo perpendicularAnchor perpendicularAttach fromLine toLine connectLine |
	
	redCurve := self redCurve.
	
	attachFrom := self attachPoint relocate: 100 @ 100.
	attachTo := self attachPoint relocate: 300 @ 400.

	anchorFrom := BlElementCenterAnchor element: attachFrom.	
	anchorTo := BlElementCenterAnchor element: attachTo.
	
	perpendicularAnchor := BlPerpendicularFractionAnchor new.
	"order of the reference anchors matters"
	perpendicularAnchor referenceAnchors: { anchorFrom . anchorTo }.
	"the length of a perpendicular is half of the distance"
	perpendicularAnchor curvatureFraction: 0.5.

	redCurve fromAnchor: anchorFrom.
	redCurve toAnchor: anchorTo.
	redCurve viaAnchor: perpendicularAnchor.
	
	"------ fancy look ------"
	
	"visual represenation of perpendicular anchor (does not influence the curve)"
	perpendicularAttach := BlEllipseElement radius: 15.
	perpendicularAttach background: (Color red alpha: 0.4).
	perpendicularAttach centerAnchor: perpendicularAnchor.
	
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
		addChildren: { redCurve . attachFrom . perpendicularAttach. attachTo . fromLine . toLine . connectLine }
]

{ #category : #'example - visual properties' }
BlBezierExamples >> redCurve [
	<gtExample>

	^ self curve border: (BlBorder paint: Color red width: 4)
]
