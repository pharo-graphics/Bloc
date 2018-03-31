api - enumeration
every: aDuration while: aWhileBlock do: aDoBlock
	"Evaluate a aDoBlock while aWhileBlock evaluates to true waiting a given amount of time between executions.
	The first evaluation of a aDoBlock is instant.
	Note: evaluation is synchronous"

	aWhileBlock whileTrue: [
		aDoBlock value.
		self date: self now + aDuration ]