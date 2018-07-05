private
merge: aCollection at: anIndex
	| newCollection |
	newCollection := anIndex = 0
		ifTrue: [ aCollection asArray , collection ]
		ifFalse: [ anIndex = self size
				ifTrue: [ collection , aCollection ]
				ifFalse: [ | tmpCollection |
					tmpCollection := Array new: collection size + aCollection size.
					tmpCollection
						replaceFrom: 1
						to: anIndex
						with: collection
						startingAt: 1.
					tmpCollection
						replaceFrom: anIndex + 1
						to: anIndex + aCollection size
						with: aCollection
						startingAt: 1.
					tmpCollection
						replaceFrom: anIndex + aCollection size + 1
						to: tmpCollection size
						with: collection
						startingAt: anIndex + 1.
					tmpCollection ] ].
	^ self class collectionRope collection: newCollection