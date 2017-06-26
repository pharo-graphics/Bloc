actions
postLoadBloc: aSpecLoader

	self
		load: 'Bloc'
		from: aSpecLoader spec versionSpec repositories map keys first.
	
	"To make OSWindow work"
	FFIExternalStructure withAllSubclassesDo: #rebuildFieldAccessors