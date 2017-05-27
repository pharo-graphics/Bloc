printing
printOn: aStream 
	"Refer to the comment in Object|printOn:."

	self origin printOn: aStream.
	aStream nextPutAll: ' corner: '.
	self corner printOn: aStream