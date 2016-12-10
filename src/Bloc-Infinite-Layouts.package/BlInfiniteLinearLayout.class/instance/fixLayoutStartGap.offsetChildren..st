layout
fixLayoutStartGap: anOffset offsetChildren: canOffsetChildren
	| aStartOffset aGap aFixOffset |
	
	aStartOffset := anOffset.
	aGap := aStartOffset - self orientation startWithPadding.
	aFixOffset := 0.
	
	aGap > 0
		"check if we should fix this gap."
		ifTrue: [ aFixOffset := (self scrollBy: aGap) negated ]
		"nothing to fix, return"
		ifFalse: [ ^ 0 ].
	
	aStartOffset := aStartOffset + aFixOffset.
	
	canOffsetChildren
		ifTrue: [ 
			"re-calculate gap, see if we could fix it"
			aGap := aStartOffset - self orientation startWithPadding.
			aGap > 0
				ifTrue: [
					self orientation moveChildrenBy: aGap negated.
					^ aFixOffset - aGap ] ].
	
	^ aFixOffset