tree - inserting
insert: aMonotoneTextSelection

	aMonotoneTextSelection < self selection
		ifTrue: [
			left
				ifNil: [ left := self class selection: aMonotoneTextSelection ]
				ifNotNil: [ left insert: aMonotoneTextSelection ] ]
		ifFalse: [ 
			right
				ifNil: [ right := self class selection: aMonotoneTextSelection ]
				ifNotNil: [ right insert: aMonotoneTextSelection ] ].
	high := high max: ((left ifNil: [ 0 ] ifNotNil: #high) max: (right ifNil: [ 0 ] ifNotNil: #high))