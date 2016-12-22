*Bloc-Sparta
fullDrawOnSpartaCanvas: aCanvas
	| aBoundsInWindow |
	
	aBoundsInWindow := self boundsInWindow.
	
	"No need to render elements smaller than half of a pixel"
	(aBoundsInWindow width min: aBoundsInWindow height) < 1 ifTrue: [ ^ self ].

	(aCanvas clip containsGlobal: aBoundsInWindow)
		ifFalse: [ ^ self ].
		
	(self isVisible and: [ self isInDirtyAreas ])
		ifFalse: [ ^ self ].

	aCanvas transform
		push;
		translateBy: self position;
		multiplyBy: self transform;
		apply.
		
	aCanvas clip
		push: self boundsInLocal.

	[ self drawOnSpartaCanvas: aCanvas ] ensure: [
		"We should pop clip and transform in reversed exact order,
		otherwise backend transformation matrix may become broken"
		aCanvas clip pop.
		aCanvas transform pop.
		self dirty: false ]