api - enumeration
every: aDuration while: aWhileBlock do: aDoBlock
	"Evaluate a aDoBlock while aWhileBlock evaluates to true waiting a given amount of time between executions.
	The first evaluation of a aDoBlock is instant.
	Note: evaluation is synchronous"
	| aStartTime aCount |

	aStartTime := self now.
	aCount := 0.

	aWhileBlock whileTrue: [
		| anExpectedTime aCurrentTime |
		aDoBlock value.
		
		aCount := aCount + 1.
		
		anExpectedTime := aStartTime + (aDuration * aCount).
		aCurrentTime := self now.
		(anExpectedTime - aCurrentTime) wait ]