Extension { #name : #BlSpace }

{ #category : #'*Bloc-Simulation' }
BlSpace class >> pulseUntilEmptyTaskQueue: aSpace timeout: aDuration [
	self
		deprecated: 'Use (BlSpaceSimulator forSpace: aSpace) timeout: aDuration; pulseUntilEmptyTaskQueue instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlSpaceSimulator forSpace: aSpace)
		timeout: aDuration;
		pulseUntilEmptyTaskQueue
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> pulseUntilSpaceOpenedAndEmptyTaskQueue: aSpace timeout: aDuration [
	self
		deprecated: 'Use (BlSpaceSimulator forSpace: aSpace) timeout: aDuration; pulseUntilSpaceOpenedAndEmptyTaskQueue instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlSpaceSimulator forSpace: aSpace)
		timeout: aDuration;
		pulseUntilSpaceOpenedAndEmptyTaskQueue
]
