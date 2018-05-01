pulse
dispatchTimeEvent: aSpaceStepEventClass during: aBlock
	| aStartTime |
	
	aStartTime := self time now.
	aBlock value.
	self eventDispatcher dispatchEvent:
			(aSpaceStepEventClass new
				start: aStartTime;
				end: self time now;
				yourself)