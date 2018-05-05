api - geometry
localPosition
	"Return an event position in local coordinates of a #currentTarget"
	<return: #Point>
	
	^ self currentTarget globalPointToLocal: self position