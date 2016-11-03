as yet unclassified
globalMousePositionForEvent: anEvent
	^ hostSpace position + (anEvent x @ anEvent y)