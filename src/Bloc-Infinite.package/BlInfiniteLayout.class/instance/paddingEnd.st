geometry
paddingEnd
	"Returns the end padding of infinite element depending on layout direction."
	<return: #Number>
	
	^ self direction isLeftToRight
		ifTrue: [ infiniteElement constraints padding right ]
		ifFalse: [ infiniteElement constraints padding left ]