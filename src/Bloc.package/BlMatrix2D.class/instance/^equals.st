comparing
= anObject
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
		
		
	^ self sx = anObject sx
		and: [ self shy = anObject shy
			and: [ self shx = anObject shx
				and: [ self sy = anObject sy
					and: [ self x = anObject x
						and: [ self y = anObject y ] ] ] ] ]