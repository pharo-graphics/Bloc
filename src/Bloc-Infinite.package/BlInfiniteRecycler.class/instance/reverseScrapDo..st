accessing - cache
reverseScrapDo: aBlock
	| aScrapCount |
	
	aScrapCount := self scrapCount.
	aScrapCount isZero
		ifTrue: [ ^ self ].

	aScrapCount to: 1 by: -1 do: [ :anIndex |
		| anElement |
		anElement := self scrappedElementAt: anIndex.
		anElement ifNotNil: [ aBlock cull: anElement cull: anIndex ] ]