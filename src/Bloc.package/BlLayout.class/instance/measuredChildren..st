enumeration
measuredChildren: anElement
	"Return a collecton of the anElement's children that should be measures by the layout"
	
	^ Array streamContents: [ :aStream |
		self measuredChildren: anElement do: [ :aChild | aStream nextPut: aChild ] ]