loading - git
gitLoad: aBaselineName from: aRepositoryName
	"I load a baseline defined by aBaselineName using Iceberg from provided git repository.
	I exract target group (core / development) from baseline specification of a spec loader"
	| aLoader thePackages |
	
	aLoader := Metacello new
  		baseline: aBaselineName;
  		repository: aRepositoryName;
		"We only fetch, without actuall loading in the image. Loading will be done by iceberg"
  		fetch: self target.

	thePackages := OrderedCollection new.
	aLoader packageDirectivesDo: [ :package | thePackages add: package spec name ].

	self icebergLoad: thePackages from: aRepositoryName