layout
fixLayoutEndGap: anOffset offsetChildren: canOffsetChildren
	| anEndOffset aGap aFixOffset |
	
	anEndOffset := anOffset.
	aGap := self orientation endWithPadding - anEndOffset.
	aFixOffset := 0.
	
	aGap > 0
		"check if we should fix this gap."
		ifTrue: [ aFixOffset := (self scrollBy: aGap negated) negated ]
		"nothing to fix, return"
		ifFalse: [ ^ 0 ].
	
	"move offset according to scroll amount"
	anEndOffset := anEndOffset + aFixOffset.
	
	canOffsetChildren
		ifTrue: [ 
			"re-calculate gap, see if we could fix it"
			aGap := self orientation endWithPadding - anEndOffset.
			aGap > 0
				ifTrue: [
					self orientation moveChildrenBy: aGap.
					^ aFixOffset + aGap ] ].
	
	^ aFixOffset