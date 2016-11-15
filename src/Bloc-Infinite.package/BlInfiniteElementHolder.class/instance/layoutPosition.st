accessing
layoutPosition
	^ preLayoutPosition isDefined
		ifTrue: [ preLayoutPosition ]
		ifFalse: [ position ]