examples - physics
startTension
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller startTension closeTo: 0.5).

	^ aSplineOverScroller startTension