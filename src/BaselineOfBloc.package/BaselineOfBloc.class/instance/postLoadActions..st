actions
postLoadActions: aSpecLoader
	| group protocol columnIndex |
	group := (aSpecLoader spec required difference: aSpecLoader spec packages keys) asArray first asSymbol.
	columnIndex := group indexOf: $:.

	"we load code + plugin installation"
	columnIndex <= 0
		ifTrue: [ ^self postInstall ].
	protocol := group first: columnIndex - 1.

	"we load code only without Iceberg"
	protocol = #file
		ifTrue: [ ^ self ].

	"we load code + iceberg + plugin installation"
	protocol = #git
		ifTrue: [ self postLoadGit: aSpecLoader.
			^ self postInstall ].
		
	Error signal: 'Unknown load protocol ' , group