debug - simulation
simulateEvent: anEvent on: anElement
	"I simulate a given low level space UI events such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordiantes of the provided element"

	anElement isAttachedToSceneGraph
		ifTrue: [
			anElement space
				doLayout;
				dispatchEvent: anEvent ]
		ifFalse: [ 
			| temporarySpace topMostElement |
			topMostElement := anElement topMostParent.
			[ 
				temporarySpace := self new.
				temporarySpace root addChild: topMostElement.
				temporarySpace doLayout.
				temporarySpace dispatchEvent: anEvent.
			] ensure: [ topMostElement removeFromParent ] ]
	