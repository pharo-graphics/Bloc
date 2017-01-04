*Bloc-Sparta
fullDrawOnSpartaCanvas: aCanvas
	| aBoundsInSpace |

	aBoundsInSpace := self boundsInSpace.

	"No need to render elements smaller than half of a pixel"
	(aBoundsInSpace width min: aBoundsInSpace height) < 1 ifTrue: [ ^ self ].

	self isAttachedToSceneGraph
		ifTrue: [ (aCanvas clip containsGlobal: aBoundsInSpace scaledBy: self space windowScale)
			ifFalse: [ ^ self ]. ]
		ifFalse: [ (aCanvas clip containsGlobal: aBoundsInSpace)
			ifFalse: [ ^ self ] ].
		
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
		aCanvas transform pop ]