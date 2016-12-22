loading - git
gitLoad: aBaselineName from: aRepositoryName
	"I load a baseline defined by aBaselineName using Iceberg from provided git repository.
	I exract target group (core / development) from baseline specification of a spec loader"
	| aLoader thePackages |
	
	aLoader := Metacello new
  		baseline: aBaselineName;
  		repository: aRepositoryName;
		"We only record packages that need to be loaded, without actuall loading in the image. Loading will be done by iceberg"
  		record: self target.

	thePackages := Array
		streamContents: [ :aStream | 
			aLoader loadDirectives
				do: [ :aDirective | 
					| aProject |
					aProject := aDirective spec project.
					aDirective packageDirectivesDo: [ :aPackage | 
						| theRepositories repositoryMatches |
						theRepositories :=  aPackage spec repositories map keys.
						repositoryMatches := theRepositories isEmpty or: [ theRepositories first = aRepositoryName ].
						(repositoryMatches and: [ aPackage spec project = aProject ])
							ifTrue: [ aStream nextPut: aPackage spec name ] ] ] ].

	self icebergLoad: thePackages from: aRepositoryName