z operations
zReversed
	^ zReversedArray ifNil: [ zReversedArray := self zSorted reversed ]