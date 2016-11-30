accessing
start
	^ startStep ifNil: [ startStep := BlInfiniteLayoutStepStart new ]