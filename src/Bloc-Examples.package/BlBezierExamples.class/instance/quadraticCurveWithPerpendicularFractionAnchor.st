example - connections
quadraticCurveWithPerpendicularFractionAnchor
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