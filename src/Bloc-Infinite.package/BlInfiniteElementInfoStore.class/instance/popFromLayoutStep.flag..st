private
popFromLayoutStep: anElementHolder flag: aFlag
	
	| aRecord |
	
	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsent: [ ^ nil ].
	
	self
		assert: [ aRecord isNotNil ]
		description: [ 'An info store record must not be nil!' ].
	
	^ (aRecord flags has: aFlag)
		ifTrue: [ 
			| anInfo |
			aRecord flags remove: aFlag.
			anInfo := (aFlag = BlInfiniteInfoStoreRecordFlags Pre)
				ifTrue: [ aRecord preInfo ]
				ifFalse: [ (aFlag = BlInfiniteInfoStoreRecordFlags Post)
					ifTrue: [ aRecord postInfo ]
					ifFalse: [ self error: 'Unknown flag: ', aFlag asString ] ].
			(aRecord flags hasPre or: [ aRecord flags hasPost ]) ifFalse: [ 
				layoutHolderMap removeKey: anElementHolder ifAbsent: [ ].
				BlInfiniteElementInfoStoreRecord recycle: aRecord ].
			anInfo ]
		ifFalse: [ nil ]