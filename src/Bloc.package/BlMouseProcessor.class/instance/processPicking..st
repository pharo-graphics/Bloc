event processing
processPicking: aMouseEvent
	| aTarget |
	"if the last over target contains the point we can start picking from it"
	(aMouseEvent isMouseMove and: [ lastOverTarget isNotNil and: [ lastOverTarget containsGlobalPoint: aMouseEvent position ] ])
		ifTrue: [ aTarget := lastOverTarget pickObject: aMouseEvent position ]
		ifFalse: [ aTarget := self space root pickObject: aMouseEvent position ].
	"we have to ensure that aTarget is not nil"
	aTarget ifNil: [ aTarget := self space root ].
	^ aTarget