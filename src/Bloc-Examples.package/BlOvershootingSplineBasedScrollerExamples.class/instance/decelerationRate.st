examples - physics
decelerationRate
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller decelerationRate closeTo: 2.3582017).

	^ aSplineOverScroller decelerationRate