instance creation
onBindHolder: anElementHolder at: aPosition
	"Update holder's model"
	anElementHolder color: (Color named: (Color registeredColorNames at: aPosition) asSymbol)