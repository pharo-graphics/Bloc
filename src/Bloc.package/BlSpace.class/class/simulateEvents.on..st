debug - simulation
simulateEvents: aCollectionOfEvents on: anElement
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordiantes of the provided element"
	
	"we should update timestamps"
	aCollectionOfEvents do: [ :anEvent | anEvent timestamp: Time millisecondClockValue ].
	
	anElement isAttachedToSceneGraph
		ifTrue: [
			anElement space pulse.
			aCollectionOfEvents do: [ :anEvent | anElement space dispatchEvent: anEvent ] ]
		ifFalse: [ 
			| temporarySpace topMostElement |
			topMostElement := anElement topMostParent.
			[ 
				temporarySpace := self new.
				temporarySpace root addChild: topMostElement.
				temporarySpace pulse.
				aCollectionOfEvents do: [ :anEvent | temporarySpace dispatchEvent: anEvent ]
			] ensure: [ topMostElement removeFromParent ] ]
	