accessing - cache
reverseScrapDo: aBlock
	| aScrapCount |
	
	aScrapCount := self scrapCount.
	aScrapCount isZero
		ifTrue: [ ^ self ].

	aScrapCount to: 1 do: [ :anIndex | aBlock value: (self scrappedElementAt: anIndex) ]