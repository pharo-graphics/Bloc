as yet unclassified
wantsEvent: anEvent
	^ (super wantsEvent: anEvent) and: [ (self client = anEvent target) not ]