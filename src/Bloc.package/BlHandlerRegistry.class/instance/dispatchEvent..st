event managing
dispatchEvent: anEvent
	self handlers size = 0 ifTrue:[^ self].
	(self handlers select: [ :h | h wantsEvent: anEvent ]) do: [ :h | h handleEvent: anEvent ]