hidden
unhideChildInternal: aChildElement
	"Unmarks a child view as hidden.
	Return true if aChildElement was hidden before,
	false otherwise"
	<return: #Boolean>
	
	hiddenChildren
		remove: aChildElement
		ifAbsent: [ ^ false ].

	controller onLeftHiddenState: aChildElement.
	^ true