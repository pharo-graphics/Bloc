examples - connections
relativeCurvatureWithoutDecorations
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