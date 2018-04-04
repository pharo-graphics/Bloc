examples - sequential animation
_1_1_sequential_addFirstChild
	<gtExample>
	| aSequentialAnimation |

	aSequentialAnimation := self sequentialAnimationWithDelayAndTwoLoops.
	aSequentialAnimation add: (BlAnimation new duration: self firstSequentialDuration; loops: self firstSequentialLoops).
	
	self assert: aSequentialAnimation duration equals: self firstSequentialDuration * self firstSequentialLoops.
	
	^ aSequentialAnimation