private - animations
handleMissingPreInfoForChange: anActualElementHolder oldChangeHolder: anOldChangeElementHolder at: anActualKey

	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder == anActualElementHolder ifFalse: [ 
			| aKey |
			aKey := self changedHolderKeyOf: anElementHolder.
			aKey = anActualKey ifTrue: [
				dataSource hasStableIds
					ifTrue: [ self error: 'Two different ElementHolders have the same stable ID. Stable IDs in your data source MUST BE unique and SHOULD NOT change.' ]
					ifFalse: [ self error: 'Two different ElementHolders have the same change ID. This might happen due to inconsistent DataSource update events or if the InfinieElement lays out the same Element multiple times.' ] ] ] ]