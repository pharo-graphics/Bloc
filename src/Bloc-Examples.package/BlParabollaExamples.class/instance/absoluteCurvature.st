example - connections
absoluteCurvature
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