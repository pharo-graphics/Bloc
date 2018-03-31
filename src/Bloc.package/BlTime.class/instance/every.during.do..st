api - enumeration
every: aDuration during: aLoopDuration do: aDoBlock
	| aStartTime |
	
	aStartTime := self now.

	self
		every: aDuration
		while: [ self now < (aStartTime + aLoopDuration) ]
		do: aDoBlock