layout
fillLayoutChunkResult: aResult
	| aRemainingSpaceDelta |

	layoutState offset: layoutState offset + (aResult consumedSpace * layoutState layoutDirection multiplier).
	aRemainingSpaceDelta := self fillLayoutConsumeSpace: aResult.
	self fillLayoutResultScroll: aResult.
	
	^ aRemainingSpaceDelta