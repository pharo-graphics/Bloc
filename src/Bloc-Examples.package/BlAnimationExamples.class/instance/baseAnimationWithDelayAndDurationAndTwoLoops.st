examples - base animation
baseAnimationWithDelayAndDurationAndTwoLoops
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := BlBaseAnimation new.
	aBaseAnimation time: (BlTime simulated date: self exampleDate).

	aBaseAnimation delay: self exampleDelay.
	aBaseAnimation loops: 2.
	aBaseAnimation duration: self exampleDuration.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.

	^ aBaseAnimation