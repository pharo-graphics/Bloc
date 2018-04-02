examples - base animation
_4_1_baseAnimation_secondLoop_step_halfDelay
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _3_3_baseAnimation_step_fullDuration.
	aBaseAnimation time wait: self exampleDelay / 2.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: (self exampleDate + self exampleDelay + self exampleDuration).
	self assert: aBaseAnimation delayedStartTime equals: (self exampleDate + self exampleDelay + self exampleDuration) + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation