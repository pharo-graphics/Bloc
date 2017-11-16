layout - state
updateLayoutState: aLayoutDirection requiredSpace: aRequiredSpace canUseExistingSpace: canUseExistingSpace
	| aScrollingOffset |

	layoutState isInfinite: self resolveIsInfinite.
	layoutState extraSpace: self computeExtraLayoutSpace.
	layoutState layoutDirection: aLayoutDirection.
	
	aScrollingOffset := (aLayoutDirection isStart
		ifTrue: [ self updateLayoutStateStart ]
		ifFalse: [self updateLayoutStateEnd ]).
	layoutState availableSpace: aRequiredSpace in: self.
	canUseExistingSpace
		ifTrue: [ layoutState availableSpace: layoutState availableSpace - aScrollingOffset in: self ].
	layoutState scrollingOffset: aScrollingOffset