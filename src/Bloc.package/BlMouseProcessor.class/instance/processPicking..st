event processing
processPicking: aMouseEvent
	<return: #BlElement>
	| aTargetElement |

	"if the last over target contains the point we can start picking from it"
	(aMouseEvent isMouseMove and: [ lastOverTarget isNotNil and: [ lastOverTarget containsGlobalPoint: aMouseEvent position ] ])
		ifTrue: [ aTargetElement := lastOverTarget findMouseEventTargetAt: aMouseEvent position ]
		ifFalse: [ aTargetElement := self space root findMouseEventTargetAt: aMouseEvent position ].
	"we have to ensure that aTarget is not nil"
	aTargetElement ifNil: [ aTargetElement := self space root ].
	^ aTargetElement