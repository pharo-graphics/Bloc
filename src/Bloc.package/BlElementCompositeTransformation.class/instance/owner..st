accessing
owner: anElement
	super owner: anElement.
	self transformations do: [ :aTransformation | aTransformation owner: anElement ]