"
!Bezier curves

There are two kinds of Bezier curves supported:
- quadratic
- cubic

!!Quadratic Bezier curves

${example:BlBezierElementExamples>>#quadraticCurveWithAnchors|expandedPreview|noCode=|show=gtLiveFor:}$


!!Cubic Bezier curves

${example:BlBezierElementExamples>>#curveWithAnchors|expandedPreview|noCode=|show=#gtLiveFor:}$

"
Class {
	#name : #BlBezierElementExamples,
	#superclass : #BlGeometryElementExamples,
	#category : #'Bloc-Examples-Geometry'
}

{ #category : #examples }
BlBezierElementExamples class >> bezierControlPoints [
	<script: 'self bezierControlPoints'>
	
	self openInWindow:
		self new curveWithAnchors
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #examples }
BlBezierElementExamples class >> quadraticCurve [
	<script: 'self quadraticCurve'>
	
	self openInWindow:
		self new quadraticCurveWithAnchors
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #examples }
BlBezierElementExamples class >> quadraticCurveWithPerpendicularAnchor [
	<script: 'self quadraticCurveWithPerpendicularAnchor'>

	self openInWindow:
		self new quadraticCurveWithPerpendicularAnchor
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #examples }
BlBezierElementExamples class >> quadraticCurveWithPerpendicularFractionAnchor [
	<script: 'self quadraticCurveWithPerpendicularFractionAnchor'>

	self openInWindow:
		self new quadraticCurveWithPerpendicularFractionAnchor
		named: 'Drag control points'
		extent: 550@500
]

{ #category : #'instance creation' }
BlBezierElementExamples >> curve [
	<gtExample>
	
	^ BlBezierElement new
		zIndex: 10;
		yourself
]

{ #category : #'example - connections' }
BlBezierElementExamples >> curveWithAnchors [
	<gtExample>	
	| redCurve attachFrom attachTo firstViaAttach secondViaAttach fromLine toLine |
	
	redCurve := self redCurve.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 10 @ 150.

	firstViaAttach := self attachPoint.
	firstViaAttach relocate: 60 @ 10.
	
	secondViaAttach := self attachPoint.
	secondViaAttach relocate: 260 @ 10.

	attachTo := self attachPoint.
	attachTo relocate: 310 @ 150.

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
BlBezierElementExamples >> greyLine [
	<gtExample>

	^ self line
		border: (BlBorder paint: (Color gray alpha: 0.5) width: 1)
]

{ #category : #'instance creation' }
BlBezierElementExamples >> line [
	<gtExample>
	
	^ BlLineElement new
		zIndex: 10;
		yourself
]

{ #category : #'example - connections' }
BlBezierElementExamples >> quadraticCurveWithAnchors [
	<gtExample>	
	| redCurve attachFrom attachTo viaAttach fromLine toLine |
	
	redCurve := self redCurve.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 10 @ 160.

	viaAttach := self attachPoint.
	viaAttach relocate: 160 @ 10.

	attachTo := self attachPoint.
	attachTo relocate: 310 @ 160.

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
BlBezierElementExamples >> quadraticCurveWithPerpendicularAnchor [
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
BlBezierElementExamples >> quadraticCurveWithPerpendicularFractionAnchor [
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
BlBezierElementExamples >> redCurve [
	<gtExample>

	^ self curve border: (BlBorder paint: Color red width: 4)
]
