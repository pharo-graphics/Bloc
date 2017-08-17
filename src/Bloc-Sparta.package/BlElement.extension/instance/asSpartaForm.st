*Bloc-Sparta
asSpartaForm
	| aCanvas aFinalCanvas aBoundsInWindow aBoundsInSpace aBoundsInLocal |

	self forceLayout.

	aBoundsInLocal := (self effectBounds: BlBounds new)
		merge: self boundsInLocal;
		merge: self visualBounds.

	aBoundsInWindow := self localBoundsToWindow: aBoundsInLocal copy.
	aBoundsInSpace := self localBoundsToGlobal: aBoundsInLocal copy.

	aCanvas := Bloc preferableSpartaCanvas checker: (aBoundsInWindow corner max: 1@1).

	aCanvas transform
		push;
		translateBy: (aBoundsInSpace origin) negated + (100@100);
		scaleBy: (self isAttachedToSceneGraph
			ifTrue: [ self space windowScale ]
			ifFalse: [ 1 ]);
		apply.

	aCanvas clip
		by: aBoundsInSpace
		during: [ self fullDrawOnSpartaCanvas: aCanvas ].

	aCanvas transform pop.

	aFinalCanvas := Bloc preferableSpartaCanvas extent: (aBoundsInWindow extent max: 1@1).
	aFinalCanvas transform
		push;
		translateBy: aBoundsInSpace origin negated;
		scaleBy: (self isAttachedToSceneGraph
			ifTrue: [ self space windowScale ]
			ifFalse: [ 1 ]);
		apply.

	aFinalCanvas clip
		by: aBoundsInSpace
		during: [ self fullDrawOnSpartaCanvas: aFinalCanvas ].

	aFinalCanvas transform pop.
	"aFinalCanvas fill
		path: aFinalCanvas bounds;
		paint: (aCanvas paint surface
			source: aCanvas;
			translateBy: aBoundsInWindow origin negated);
		draw."

	^ aFinalCanvas asForm