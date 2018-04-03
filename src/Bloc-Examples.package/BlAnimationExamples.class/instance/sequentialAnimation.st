examples - sequential animation
sequentialAnimation
	<gtExample>
	| aSequentialAnimation |

	aSequentialAnimation := BlSequentialAnimation new.

	self assert: aSequentialAnimation duration equals: 0 seconds.
	self assert: aSequentialAnimation delay equals: 0 seconds.
	

	^ aSequentialAnimation