examples - massive time delta
_1_massive_oneLoopAnimation_start
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self baseAnimation.	
	aBaseAnimation duration: self exampleDuration.
	aBaseAnimation start.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.
	
	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation