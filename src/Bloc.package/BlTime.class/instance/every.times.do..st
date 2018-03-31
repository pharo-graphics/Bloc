api - enumeration
every: aDuration times: aCountOfRepeats do: aDoBlock
	"Evaluate a aDoBlock a given amount of times waiting a provided amount of time between executions.
	The first evaluation of a aDoBlock is instant.
	Note: evaluation is synchronous"
	| aCounter |
	
	aCounter := 0.
	self
		every: aDuration
		while: [ (aCounter := aCounter + 1) <= aCountOfRepeats ]
		do: aDoBlock