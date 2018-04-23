examples - massive time delta - two
_2_1_massive_twoLoopAnimation_step_oneDuration
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_twoLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation