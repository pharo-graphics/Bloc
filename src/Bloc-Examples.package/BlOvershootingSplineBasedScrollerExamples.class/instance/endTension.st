examples - physics
endTension
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller endTension closeTo: 1).

	^ aSplineOverScroller endTension