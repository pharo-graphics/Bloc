examples - base animation
_3_2_baseAnimation_step_halfOfDuration
	"in this example we see what exactly happens when half of the duration is passed"
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _3_1_baseAnimation_step_quarterOfDuration.
	aBaseAnimation time wait: self exampleDuration / 4.0.

	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.5.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration / 2.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	
	^ aBaseAnimation