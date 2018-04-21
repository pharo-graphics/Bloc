examples - sequential animation
_4_2_sequential_first_step_fullDurationAndHalf
	"The animation state must be equal to _5_1_sequential_first_secondStep_halfDuration,
	because we move time by the same amount"
	<gtExample>
	| aSequentialAnimation aFirstAnimation aSecondAnimation |
	
	aSequentialAnimation := self _4_1_sequential_first_step_halfOfDuration.
	aSequentialAnimation time wait: self firstSequentialDuration.

	aSequentialAnimation run.

	self assert: (aSequentialAnimation progress closeTo: 0.545454545).
	self assert: aSequentialAnimation elapsedTime equals: self firstSequentialDuration + (self firstSequentialDuration / 2.0).

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self assert: aSequentialAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	
	aFirstAnimation := aSequentialAnimation animations first.
	
	self assert: aFirstAnimation progress equals: 0.5.
	self assert: aFirstAnimation elapsedTime equals: self firstSequentialDuration / 2.0.

	self assert: aFirstAnimation isStarted.
	self assert: aFirstAnimation isRunning.

	self assert: aFirstAnimation startTime equals: self exampleDate + self exampleDelay + self firstSequentialDuration.
	self assert: aFirstAnimation delayedStartTime equals: self exampleDate + self exampleDelay + self firstSequentialDuration.
	
	self assert: aFirstAnimation loops equals: self firstSequentialLoops.
	self assert: aFirstAnimation repeats equals: 1.
	self assert: aFirstAnimation delay equals: 0 seconds.
	
	aSecondAnimation := aSequentialAnimation animations second.
	
	self assert: aSecondAnimation progress equals: 0.

	self assert: aSecondAnimation isStarted not.
	self assert: aSecondAnimation isRunning not.
	
	self assert: aSecondAnimation loops equals: self secondSequentialLoops.
	self assert: aSecondAnimation repeats equals: 0.
	self assert: aSecondAnimation delay equals: self secondSequentialDelay.
	
	^ aSequentialAnimation