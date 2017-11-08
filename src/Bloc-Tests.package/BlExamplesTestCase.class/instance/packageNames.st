configuration
packageNames
	^ ((#gtExample senders select: [ :each | each package name beginsWith: 'Bloc' ])
		groupedBy: [ :each | each package name ]) keys