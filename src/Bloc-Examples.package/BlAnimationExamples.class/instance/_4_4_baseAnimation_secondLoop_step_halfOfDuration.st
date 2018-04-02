examples - base animation
_4_4_baseAnimation_secondLoop_step_halfOfDuration
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _4_3_baseAnimation_secondLoop_step_quarterOfDuration.
	aBaseAnimation time wait: self exampleDuration / 4.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.5.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration / 2.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: (self exampleDate + self exampleDelay + self exampleDuration).
	self assert: aBaseAnimation delayedStartTime equals: (self exampleDate + self exampleDelay + self exampleDuration) + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation