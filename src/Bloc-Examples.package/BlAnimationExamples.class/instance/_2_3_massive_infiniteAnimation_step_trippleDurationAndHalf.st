examples - massive time delta - infinite
_2_3_massive_infiniteAnimation_step_trippleDurationAndHalf
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_infiniteAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 3.5.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 0.5.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration / 2.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.
	self assert: aBaseAnimation isInfinite.

	self assert: aBaseAnimation startTime equals: self exampleDate + (self exampleDuration * 3).
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + (self exampleDuration * 3).
	
	self assert: aBaseAnimation loops equals: Float infinity.
	self assert: aBaseAnimation repeats equals: 3.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation