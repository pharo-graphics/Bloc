private
createIndex: theKeys
	| size result keyToIndex |
	size := theKeys size.
	result := Array new: size withAll: 0.
	keyToIndex := Dictionary new.
	
	1 to: size do: [ :i |
		| key index |
		key := theKeys at: i.
		index := keyToIndex at: key ifAbsentPut: [ keyToIndex size + 1 ].
		result at: i put: index ].
	^ result