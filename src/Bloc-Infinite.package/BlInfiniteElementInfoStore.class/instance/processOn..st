processing
processOn: aProcessor
	"I am doing a hard work processing appearing/disappearing elements.
	
	Processor must have the following API:
		- unused: anElementHolder
		- processDisappeared: anElementHolder preInfo: aBlInfiniteItemInfoHolder postInfo: aBlInfiniteItemInfoHolder
		- processAppeared: anElementHolder preInfo: aBlInfiniteItemInfoHolder postInfo: aBlInfiniteItemInfoHolder
		- processPersistent: anElementHolder preInfo: aBlInfiniteItemInfoHolder postInfo: aBlInfiniteItemInfoHolder"

	layoutHolderMap associations do: [ :aKeyValuePair |
		| anElementHolder aRecord |
		anElementHolder := aKeyValuePair key.
		aRecord := aKeyValuePair value.
		"anElementHolder is guaranteed to be one of the keys, otherwise there is something
		really bad happening"
		layoutHolderMap removeKey: anElementHolder. 
		
		(aRecord flags hasAppear and: [ aRecord flags hasDisappeared ])
			"Appeared then disappeared. Not useful for animations."
			ifTrue: [ aProcessor unused: anElementHolder ]
			ifFalse: [ aRecord flags hasDisappeared
				ifTrue: [ aRecord preInfo isNil
					"similar to appear disappear but happened between different layout passes.
					this can happen when the layout manager is using auto-measure"
					ifTrue: [ aProcessor unused: anElementHolder ]
					ifFalse: [ aProcessor processDisappeared: anElementHolder preInfo: aRecord preInfo postInfo: aRecord postInfo ] ]
				ifFalse: [ (aRecord flags hasAppear and: [ aRecord flags hasPre and: [ aRecord flags hasPost ] ])
					"Appeared in the layout but not in the data source (e.g. entered the viewport)"
					ifTrue: [ aProcessor processAppeared: anElementHolder preInfo: aRecord preInfo postInfo: aRecord postInfo ]
					ifFalse: [ (aRecord flags hasPre and: [ aRecord flags hasPost ])
						"Persistent in both passes. Animate persistence"
						ifTrue: [ aProcessor processPersistent: anElementHolder preInfo: aRecord preInfo postInfo: aRecord postInfo ]
						ifFalse: [ aRecord flags hasPre
							"Was in pre-layout, never been added to post layout"
							ifTrue: [ aProcessor processDisappeared: anElementHolder preInfo: aRecord preInfo postInfo: nil ]
							ifFalse: [ aRecord flags hasPost
								"Was not in pre-layout, been added to post layout"
								ifTrue: [ aProcessor processAppeared: anElementHolder preInfo: aRecord preInfo postInfo: aRecord postInfo ]
								ifFalse: [ aRecord flags hasAppear
									"Scrap view. RecyclerView will handle removing/recycling this."
									ifFalse: [ self error: 'Record has invalid flag combination!' ] ] ] ] ] ] ].
		BlInfiniteElementInfoStoreRecord recycle: aRecord ]