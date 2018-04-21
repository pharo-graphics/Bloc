examples - massive time delta
_2_2_massive_oneLoopAnimation_step_twiceDuration
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_oneLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 2.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.
	
	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation