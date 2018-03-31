examples - physics
physicalCoefficient
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.
	
	"physical coefficient depends on ppi"
	self assert: (aSplineOverScroller physicalCoefficient closeTo: 31134.12).

	^ aSplineOverScroller physicalCoefficient