instance creation
buildDataSourceChangeFlagsForAnimations: anElementHolder
	
	| theFlags |
	
	anElementHolder isInvalid
		ifTrue: [ ^ BlInfiniteItemAnimatorFlags new addInvalidated ].
	
	theFlags := (BlInfiniteItemAnimatorFlags fromFlags: anElementHolder flags)
		and: [ BlInfiniteItemAnimatorFlags new addInvalidated; addRemoved; addChanged; value ].
		
	theFlags hasInvalidated
		ifFalse: [ 
			| anOldPosition aNewPosition |
			anOldPosition := anElementHolder previousPosition.
			aNewPosition := anElementHolder dataSourcePosition.
			(anOldPosition ~= NoPosition and: [
				aNewPosition ~= NoPosition and: [ 
					anOldPosition ~= aNewPosition ] ])
				ifTrue: [ theFlags addMoved ] ].

	^ theFlags