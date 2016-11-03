accessing
includeBefore: newBefore after: newAfter
	super includeBefore: newBefore after: newAfter.
	size := size max: (newBefore + newAfter).