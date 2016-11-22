recycling
unscrapHolder: anElementHolder
	"Remove a previously scrapped element holder from the pool of eligible scrap.
	An element will no longer be eligible for reuse until re-scrapped or until
	it is explicitly removed and recycled"

	anElementHolder isInChangeScrap
		ifTrue: [ changedScrap remove: anElementHolder ]
		ifFalse: [ attachedScrap remove: anElementHolder ].
		
	anElementHolder detachRecycler