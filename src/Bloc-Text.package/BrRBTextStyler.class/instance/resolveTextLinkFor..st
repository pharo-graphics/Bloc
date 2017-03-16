private
resolveTextLinkFor: aVariableNode

	aVariableNode binding isGlobalVariable
		ifTrue: [ ^ BrTextClassLink className: aVariableNode name ].
		
	^ BrTextVariableLink variableName: aVariableNode name