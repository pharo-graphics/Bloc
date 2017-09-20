change reporting
invalidateInParent
	| aBlBounds |

	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].

	aBlBounds := self invalidationBounds: self class invalidationBounds.
	self localBoundsToParent: aBlBounds.
	self hasParent
		ifTrue: [ self parent invalidRect: aBlBounds ]
		ifFalse: [ self space invalidRect: aBlBounds from: self ]