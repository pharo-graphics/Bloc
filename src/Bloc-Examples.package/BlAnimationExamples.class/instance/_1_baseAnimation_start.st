examples - base animation
_1_baseAnimation_start
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self baseAnimationWithDelayAndDurationAndTwoLoops.	
	aBaseAnimation start.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation