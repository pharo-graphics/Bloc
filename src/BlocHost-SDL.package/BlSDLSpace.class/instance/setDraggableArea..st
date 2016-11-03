private
setDraggableArea: aRectangle

	| myCallback sdlRect |
	
	sdlRect := aRectangle asSDLRect.
	
	myCallback := DraggableCallback on: [ :aWindow :pt :data |
			(pt x > sdlRect x) & (pt x < sdlRect w) & (pt y > sdlRect y) & (pt y < sdlRect h) ifTrue: [ 1 ] ifFalse: [ 0 ].
		].
	
	^sdlWindow setHitTest: myCallback.