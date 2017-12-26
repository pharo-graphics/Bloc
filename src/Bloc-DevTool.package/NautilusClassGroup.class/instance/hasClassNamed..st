accessing
hasClassNamed: aClassName
	^ self classes anySatisfy: [ :class | class name = aClassName ]