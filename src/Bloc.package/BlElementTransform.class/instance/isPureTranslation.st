testing
isPureTranslation
	"Return true if the receiver specifies no rotation or scaling and represents only translation in xy 2D plane"
	<return: #Boolean>
	
	^ self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D isPureTranslation ]
		ifFalse: [ 
			self shouldBeImplemented ]