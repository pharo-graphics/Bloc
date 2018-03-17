private utilities
constraintsHashCode: anElement
	
	^ anElement children accountedByLayout inject: 1 into: [ :hash :child |
		child visibility isGone
			ifTrue: [ hash ]
			ifFalse: [ hash bitXor: child constraints hash ] ]