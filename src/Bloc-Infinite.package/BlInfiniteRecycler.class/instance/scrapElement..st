recycling
scrapElement: anElement
	"Mark an attached element as scrap. Scrap element are still attached
	to their parent infinite element but are eligible for rebinding and reuse.
	Requests for an element at a given position may return a reused or rebound scrap element instance.
	anElement must not be nil"
	| anElementHolder |
	
	anElementHolder := self controller childHolderOf: anElement.

	(anElementHolder isRemoved or: [
		anElementHolder isInvalid or: [ 
			anElementHolder isUpdated not or: [ 
				self controller canReuseUpdatedElementHolder: anElementHolder ] ] ])
		ifTrue: [ 
			(anElementHolder isInvalid and: [
				anElementHolder isRemoved not and: [ 
					self controller hasStableIds not ] ])
				ifTrue: [ self error: 'Can not scrap invalid elements, because they can not be reused from scrap and should be rebound from recycler pool instead' ].
			
			anElementHolder recycler: self inChangeScrap: false.
			attachedScrap add: anElementHolder ]
		ifFalse: [ 
			anElementHolder recycler: self inChangeScrap: true.
			changedScrap add: anElementHolder ]