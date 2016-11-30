adding/removing
removeHolder: anElementHolder
	"Removes the anElementHolder from all lists"
	
	oldChangedHolders removeKey: anElementHolder ifAbsent:  [  ].
	(layoutHolderMap removeKey: anElementHolder ifAbsent:  [ nil ])
		ifNotNil: [ :aRecord | BlInfiniteElementInfoStoreRecord recycle: aRecord ]