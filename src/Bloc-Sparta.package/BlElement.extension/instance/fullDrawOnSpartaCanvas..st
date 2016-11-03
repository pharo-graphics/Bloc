*Bloc-Sparta
fullDrawOnSpartaCanvas: aCanvas

	"No need to render elements smaller than half of a pixel"
	(self boundsInSpace width min: self boundsInSpace height) < 1 ifTrue: [ ^ self ].

	(aCanvas clip containsGlobal: self boundsInSpace)
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