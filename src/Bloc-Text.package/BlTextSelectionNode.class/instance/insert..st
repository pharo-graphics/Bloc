tree - inserting
insert: aMonotoneTextSelection

	aMonotoneTextSelection < self selection
		ifTrue: [
			left
				ifNil: [ left := self createNode: aMonotoneTextSelection ]
				ifNotNil: [ left insert: aMonotoneTextSelection ] ]
		ifFalse: [ 
			right
				ifNil: [ right := self createNode: aMonotoneTextSelection ]
				ifNotNil: [ right insert: aMonotoneTextSelection ] ].
	high := high max: ((left ifNil: [ 0 ] ifNotNil: #high) max: (right ifNil: [ 0 ] ifNotNil: #high))