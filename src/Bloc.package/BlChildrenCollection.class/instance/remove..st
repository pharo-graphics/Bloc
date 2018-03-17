children - removing
remove: anElement
	| anIndex |

	anIndex := self indexOf: anElement.
	anIndex isZero
		ifTrue: [ self errorNotFound: anElement ].
		
	self removeAt: anIndex