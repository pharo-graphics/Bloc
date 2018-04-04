examples - sequential animation
sequentialAnimationWithDelay
	<gtExample>
	| aSequentialAnimation |

	aSequentialAnimation := BlSequentialAnimation new.
	aSequentialAnimation time: (BlTime simulated date: self exampleDate).
	
	aSequentialAnimation delay: self exampleDelay.

	self assert: aSequentialAnimation duration equals: 0 seconds.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	self assert: aSequentialAnimation loops equals: 1.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation isStarted not.
	self assert: aSequentialAnimation isRunning not.

	^ aSequentialAnimation