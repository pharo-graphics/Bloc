private - accessing
isRecyclable: aBoolean
	"Informs the recycler whether this item can be recycled or not.
	Elements which are not recyclable will not be reused for other items until isRecyclable: is
	later set to true. Message sends to isRecyclable: should always be paired (one send of isRecyclable: false
	should always be matched with a later message send to isRecyclable: true).
	Pairs of sends may be nested, as the state is internally reference-counted"

	recyclableCount := aBoolean
		ifTrue: [ recyclableCount - 1 ]
		ifFalse: [ recyclableCount + 1 ].
	
	recyclableCount < 0
		ifTrue: [ 
			self error: 'isRecyclable decremented below 0. Unmatched message sent of isRecyclable:!'.
			recyclableCount := 0 ].
	
	(aBoolean not and: [ recyclableCount = 1 ])
		ifTrue: [ self flags addNotRecyclable ].

	(aBoolean and: [ recyclableCount = 0 ])
		ifTrue: [ self flags clearNotRecyclable ]