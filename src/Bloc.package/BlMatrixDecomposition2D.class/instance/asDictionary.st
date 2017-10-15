converting
asDictionary
	<return: #Dictionary>
	^ { 
		'Translation' -> self translation.
		'Scale' -> self scale.
		'Rotation angle (degrees)' -> self angle.
		'Inner matrix' -> self matrix
	} asOrderedDictionary