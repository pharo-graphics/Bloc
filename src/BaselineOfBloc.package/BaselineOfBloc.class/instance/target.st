accessing
target
	"Return current group's target as symbol.
	For example if group is #'git:development' I return #'development'"
	<return: #Symbol>
		
	^ (group last: group size - (group indexOf: $:)) asSymbol