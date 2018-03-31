examples - instance creation
scrollFlinger
	<gtExample>
	| aFlinger |

	aFlinger := BlScrollFlinger new.
	self assert: aFlinger interpolator equals: BlQuinticInterpolator default.
	
	^ aFlinger