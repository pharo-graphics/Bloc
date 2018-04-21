examples - base animation
infiniteAnimation
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: (BlTime simulated date: self exampleDate).
	aBaseAnimation beInfinite.

	self assert: aBaseAnimation loops equals: Float infinity.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.
	self assert: aBaseAnimation isInfinite.

	^ aBaseAnimation