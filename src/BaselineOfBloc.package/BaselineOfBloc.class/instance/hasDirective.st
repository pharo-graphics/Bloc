testing
hasDirective
	"Return true if there is a special directive defined by group prefix.
	For example if group is 'git:development', then directive is 'git' and I return true.
	If group is just 'core', which means there is no directive I return false"
	<return: #Boolean>
	
	^ (group indexOf: $:) > 0