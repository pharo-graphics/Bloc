*Bloc-Sparta
asSpartaForm
	| aCanvas aFinalCanvas aBoundsInWindow aBoundsInSpace aBoundsInLocal |
	
	self forceLayout.
	
	aBoundsInLocal := (self effectBounds: BlBounds new) merge: self boundsInLocal.
	aBoundsInWindow := self localBoundsToWindow: aBoundsInLocal.
	aBoundsInSpace := self localBoundsToGlobal: aBoundsInLocal.

	aCanvas := BlSettings preferableSpartaCanvas checker: (aBoundsInWindow corner max: 1@1).

	aCanvas transform
		push;
		scaleBy: (self isAttachedToSceneGraph
			ifTrue: [ self space windowScale ]
			ifFalse: [ 1 ]);
		apply.

	aCanvas clip
		by: aBoundsInSpace
		during: [ self fullDrawOnSpartaCanvas: aCanvas ].

	aCanvas transform pop.

	aFinalCanvas := BlSettings preferableSpartaCanvas extent: (aBoundsInWindow extent max: 1@1).
	aFinalCanvas fill
		path: aFinalCanvas bounds;
		paint: (aCanvas paint surface
			source: aCanvas;
			translateBy: aBoundsInWindow origin negated);
		draw.

	^ aFinalCanvas asForm