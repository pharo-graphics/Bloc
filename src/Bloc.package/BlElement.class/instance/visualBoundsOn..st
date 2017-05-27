geometry bounds
visualBoundsOn: aCanvas
	"Return my visual bounds as a Rectangle.
	Visual bounds only take border and geometry into account.
	If a border is of inner type, then visual bounds are the same
	as geometry bounds, otherwise visual bounds are larger than geometry ones"
	<return: #Rectangle>
	
	^ (self visualBounds: BlBounds new on: aCanvas) asRectangle