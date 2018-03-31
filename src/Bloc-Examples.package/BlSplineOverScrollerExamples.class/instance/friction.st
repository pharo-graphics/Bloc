examples - physics
friction
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller friction closeTo: 0.015).

	^ aSplineOverScroller friction