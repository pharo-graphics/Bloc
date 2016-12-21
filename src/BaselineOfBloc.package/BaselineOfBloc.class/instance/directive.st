accessing
directive
	"Return current group's directive as symbol.
	For example if group is #'git:development' I return #'git' "
	<return: #Symbol>
	self
		assert: [ self hasDirective ]
		description: [ 'Group must have directive in order to query for it' ].
		
	^ (group first: (group indexOf: $:) - 1) asSymbol