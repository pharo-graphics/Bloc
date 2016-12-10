accessing - cache
reverseScrapDo: aBlock
	| aScrapCount |
	
	aScrapCount := self scrapCount.
	aScrapCount isZero
		ifTrue: [ ^ self ].

	aScrapCount to: 1 by: -1 do: [ :anIndex | aBlock cull: (self scrappedElementAt: anIndex) cull: anIndex ]