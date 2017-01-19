event managing
dispatchEvent: anEvent
	"inlined version of select:thenDo:"

	| theHandlers |
	theHandlers := self handlers.
	1 to: theHandlers size do: [ :index | | each |
		((each := theHandlers at: index) wantsEvent: anEvent)
			ifTrue: [ each handleEvent: anEvent ] ]