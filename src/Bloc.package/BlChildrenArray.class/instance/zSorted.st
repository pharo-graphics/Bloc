z operations
zSorted
	^ zArray ifNil: [ zArray := array sorted: [ :a :b | a zIndex > b zIndex ] ]