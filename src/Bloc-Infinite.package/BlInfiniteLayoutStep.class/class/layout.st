accessing
layout
	^ layoutStep ifNil: [ layoutStep := BlInfiniteLayoutStepLayout new ]