accessing
insert: aBoolean at: index
	index > array size
		ifTrue: [ 
			self ensureNext.
			next insert: aBoolean at: index - array size ]
		ifFalse: [ 
			| last prevArray|
			last := array last = true asBit.
			prevArray := array.
			array := self newArray.
			array replaceFrom: index + 1 to: prevArray size with: prevArray startingAt: index.
			array replaceFrom: 1 to: index - 1 with: prevArray startingAt: 1.
			array byteAt: index put: aBoolean asBit.
			(last or: [ next isNotNil ])
				ifTrue: [ 
					self ensureNext.
					next insert: last at: 1 ] ]
			
