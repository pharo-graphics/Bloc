private recycling
elementFor: aPosition dryRun: dryRun
	| holder  fromScrap fetchedResult bound itemElement|
	(aPosition < 1 and: [ aPosition > self context dataSource itemCount ])
		ifTrue: [ Error signal: 'Position is out of bounds!' ].

	fetchedResult := fetcher elementFor: aPosition dryRun: dryRun context: self context.
	holder := fetchedResult key.
	fromScrap := fetchedResult value.
	
	self assert: holder isNotNil.
	self assert: fromScrap isNotNil.
	
	bound := false.
	(self context state isPreLayout and: [ holder isBound ])
		ifTrue: [ holder preLayoutPosition: aPosition ]
		ifFalse: [
			(holder isBound not or: [ holder needsUpdate or: [ holder isInvalid ] ]) ifTrue: [
				| offsetPosition |
				holder isRemoved ifTrue: [ Error signal: 'Removed holder should come here only in pre-layout!' ].
				offsetPosition := self context dataSourceController computePositionOffset: aPosition.
				holder context: self context.
				self context dataSource bindHolder: holder at: offsetPosition.
				bound := true.
				self context state isPreLayout
					ifTrue: [ holder preLayoutPosition: aPosition ] ] ].
	
	itemElement := holder itemElement.
	itemElement constraints holder: holder.
	itemElement constraints pendingInvalidate: (fromScrap and: [ bound ]).
	^ itemElement