examples - sequential animation
_3_1_sequential_step_halfDelay
	"in this example we see what exactly happens when a half of the delay elapsed"
	<gtExample>
	| aSequentialAnimation |
	
	aSequentialAnimation := self _2_1_sequential_step.
	aSequentialAnimation time wait: self exampleDelay / 2.0.

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