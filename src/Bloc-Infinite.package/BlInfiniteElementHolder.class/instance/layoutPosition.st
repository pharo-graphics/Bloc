accessing
layoutPosition
	"Returns the position of the ElementHolder in terms of the latest layout pass"
	<return: #Number>

	^ preLayoutPosition = BlInfiniteElement noPosition
		ifTrue: [ preLayoutPosition ]
		ifFalse: [ position ]