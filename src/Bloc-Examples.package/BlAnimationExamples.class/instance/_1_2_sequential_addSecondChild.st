examples - sequential animation
_1_2_sequential_addSecondChild
	<gtExample>
	| aSequentialAnimation aTotalDuration |

	aSequentialAnimation := self _1_1_sequential_addFirstChild.
	aSequentialAnimation add: (BlAnimation new
		duration: self secondSequentialDuration;
		loops: self secondSequentialLoops;
		delay: self secondSequentialDelay).
	
	aTotalDuration := self firstSequentialDuration * self firstSequentialLoops.
	aTotalDuration := aTotalDuration + ((self secondSequentialDuration + self secondSequentialDelay) * self secondSequentialLoops).
	
	self assert: aSequentialAnimation duration equals: aTotalDuration.
	
	^ aSequentialAnimation