geometry
paddingStart
	"Returns the start padding of infinite element depending on layout direction."
	<return: #Number>

	^ self direction isLeftToRight
		ifTrue: [ infiniteElement constraints padding left  ]
		ifFalse: [ infiniteElement constraints padding right ]