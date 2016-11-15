accessing
insert: aBoolean at: index

	index > array size
		ifTrue: [ 
			self ensureNext.
			next insert: aBoolean at: index - array size ]
		ifFalse: [ 
			array := array copyReplaceFrom: index to: index - 1 with: { aBoolean asBit }	]