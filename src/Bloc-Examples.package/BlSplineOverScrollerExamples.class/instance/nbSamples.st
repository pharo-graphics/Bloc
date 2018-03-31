examples - physics
nbSamples
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self
		assert: aSplineOverScroller nbSamples
		equals: 100.

	^ aSplineOverScroller nbSamples