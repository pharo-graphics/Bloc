enumeration
layeredChildren: anElement
	"Return a collecton of the anElement's children that should be layered out by the layout"
	
	^ Array streamContents: [ :aStream |
		self layeredChildren: anElement do: [ :aChild | aStream nextPut: aChild ] ]