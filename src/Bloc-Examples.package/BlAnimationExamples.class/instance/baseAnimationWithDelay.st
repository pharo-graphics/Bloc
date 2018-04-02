examples - base animation
baseAnimationWithDelay
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := BlBaseAnimation new.
	aBaseAnimation time: (BlTime simulated date: self exampleDate).

	aBaseAnimation delay: self exampleDelay.

	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.

	^ aBaseAnimation