examples - base animation
_3_3_baseAnimation_step_fullDuration
	"in this example we see what exactly happens when the whole duration is passed"
	<gtExample>
	| aBaseAnimation loopDoneListener loopDoneCount |

	aBaseAnimation := self _3_2_baseAnimation_step_halfOfDuration.
	aBaseAnimation time wait: self exampleDuration / 2.0.

	loopDoneCount := 0.
	loopDoneListener := BlEventHandler on: BlAnimationLoopDoneEvent do: [ :anEvent | loopDoneCount := loopDoneCount + 1 ].
	aBaseAnimation addEventHandler: loopDoneListener.

	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.
	self assert: loopDoneCount equals: 1.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	aBaseAnimation removeEventHandler: loopDoneListener.
	
	^ aBaseAnimation