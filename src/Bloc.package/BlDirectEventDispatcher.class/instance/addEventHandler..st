api - adding/removing
addEventHandler: aHandler
	
	"It is not very common to have event handlers so we initialize registry lazily"
	handlers ifNil: [
		handlers := self defaultHandlerRegistry ].
	handlers add: aHandler.

	"send hook AFTER handler is added"
	aHandler onInstalledIn: self owner