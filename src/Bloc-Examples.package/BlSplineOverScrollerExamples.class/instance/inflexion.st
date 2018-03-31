examples - physics
inflexion
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller inflexion closeTo: 0.35).

	^ aSplineOverScroller inflexion