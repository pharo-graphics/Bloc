hidden
unhideChildInternal: aChildElement
	<return: #Boolean>
	
	hiddenChildren remove: aChildElement ifAbsent: [ ^ false ].
	controller onLeftHiddenState: aChildElement.
	^ true