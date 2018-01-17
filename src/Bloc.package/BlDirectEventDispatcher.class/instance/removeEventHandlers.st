api - adding/removing
removeEventHandlers
	"Remove all my event handlers"
	handlers ifNil: [ ^ self ].
	
	handlers do: [ :aHandler | self removeEventHandler: aHandler ]