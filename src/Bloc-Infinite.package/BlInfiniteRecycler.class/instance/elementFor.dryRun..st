private
elementFor: aPosition dryRun: dryRun
	"I do a hard work obtaining element for the data at a position in data source.
	@see elementFor: for more information"
	<return: #BlElement>

	| holder  fromScrap fetchedResult bound itemElement|
	
	(aPosition < 1 and: [ aPosition > self controller dataSourceItemCount ])
		ifTrue: [ Error signal: 'Position is out of bounds!' ].

	fetchedResult := fetcher elementFor: aPosition dryRun: dryRun controller: self controller.
	holder := fetchedResult key.
	fromScrap := fetchedResult value.

	self assert: holder isNotNil.
	self assert: fromScrap isNotNil.

	bound := false.
	(self controller isPreLayout and: [ holder isBound ])
		ifTrue: [ holder preLayoutPosition: aPosition ]
		ifFalse: [
			(holder isBound not or: [ holder needsUpdate or: [ holder isInvalid ] ]) ifTrue: [
				| offsetPosition |
				holder isRemoved ifTrue: [ Error signal: 'Removed holder should come here only in pre-layout!' ].
				offsetPosition := self controller computePositionOffset: aPosition.
				holder infiniteElement: self controller infiniteElement.
				self controller bindHolder: holder at: offsetPosition.
				bound := true.
				self controller isPreLayout
					ifTrue: [ holder preLayoutPosition: aPosition ] ] ].
	
	self flag: 'Update to use layout specific constraints!'.
	itemElement := holder itemElement.
	itemElement constraints holder: holder.
	itemElement constraints pendingInvalidate: (fromScrap and: [ bound ]).
	^ itemElement