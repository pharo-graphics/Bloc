as yet unclassified
postLoadGit: aSpecLoader
	|group loadDirective packages|

	group := (aSpecLoader spec required difference: aSpecLoader spec packages keys) asArray first asSymbol.
	group := group last: (group size - (group indexOf: $:)).
	loadDirective := Metacello new
  		baseline: 'Bloc';
  		repository: aSpecLoader spec versionSpec repositories map keys first;
  		fetch: group.

	packages := OrderedCollection new.
	loadDirective packageDirectivesDo: [ :package | packages add: package spec name ].
	
	self ensureIceberg.
	self loadBlocInIceberg: packages.
	