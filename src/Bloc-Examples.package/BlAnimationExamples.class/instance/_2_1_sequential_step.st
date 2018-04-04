examples - sequential animation
_2_1_sequential_step
	<gtExample>
	| aSequentialAnimation |

	aSequentialAnimation := self _1_2_sequential_addSecondChild.
	aSequentialAnimation run.

	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation elapsedTime equals: 0 seconds.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self assert: aSequentialAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	
	^ aSequentialAnimation