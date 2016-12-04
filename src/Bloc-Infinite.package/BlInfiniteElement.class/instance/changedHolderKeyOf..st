private - positions
changedHolderKeyOf: anElementHolder
	
	<return: #Number>
	
	^ dataSource hasStableIds
		ifTrue: [ anElementHolder itemId ]
		ifFalse: [ anElementHolder position ]