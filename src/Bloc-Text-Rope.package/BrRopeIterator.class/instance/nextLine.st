accessing
nextLine
	| lineFound initialValue aSegment |

	initialValue := self isNewLine: self peek.		
	lineFound := false.

	aSegment := self nextSegment: [ :item |
		lineFound
			ifFalse: [ (self isNewLine: item)
				ifTrue: [ lineFound := true ]
				ifFalse: [ initialValue ] ]
			ifTrue: [ initialValue not ] ].

	(self hasNext and: [ self isNewLine: self peek ])
		ifTrue: [ self next ].

	^ aSegment