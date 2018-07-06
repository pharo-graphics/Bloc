text - accessing
textOffset
	"Return absolute text offset to better deal with sub-texts"
	<return: #Number>
	
	^ ((self start - 1) max: 0) + self text textOffset