event handling
convertMousePosition: anEvent andDo: aBlock
   "handles only events fired on top of the panelRect"

	(self window layoutBounds containsPoint: anEvent position)
		ifFalse: [ ^ self window handleEvent: anEvent ].
	"changes event position to be relative to the panelRect, not to the world"
	anEvent setPosition: anEvent position - self window layoutBounds origin.
	aBlock value: anEvent