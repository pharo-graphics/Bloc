examples - base animation
_4_5_baseAnimation_secondLoop_step_fullDuration
	<gtExample>
	| aBaseAnimation loopDoneCount loopDoneListener |

	aBaseAnimation := self _4_4_baseAnimation_secondLoop_step_halfOfDuration.
	aBaseAnimation time wait: self exampleDuration / 2.0.
	
	loopDoneCount := 0.
	loopDoneListener := BlEventHandler on: BlAnimationLoopDoneEvent do: [ :anEvent | loopDoneCount := loopDoneCount + 1 ].
	aBaseAnimation addEventHandler: loopDoneListener.
	
	aBaseAnimation run.	

	self assert: aBaseAnimation progress equals: 1.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.
	self assert: loopDoneCount equals: 1.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self assert: aBaseAnimation startTime equals: (self exampleDate + self exampleDelay + self exampleDuration).
	self assert: aBaseAnimation delayedStartTime equals: (self exampleDate + self exampleDelay + self exampleDuration) + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	aBaseAnimation removeEventHandler: loopDoneListener.

	^ aBaseAnimation