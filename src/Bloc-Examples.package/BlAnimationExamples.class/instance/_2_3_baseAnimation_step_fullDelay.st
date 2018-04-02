examples - base animation
_2_3_baseAnimation_step_fullDelay
	"in this example we see what exactly happens when the whole delay elapsed"
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _2_2_baseAnimation_step_halfDelay.
	aBaseAnimation time wait: self exampleDelay / 2.0.

	aBaseAnimation run.

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