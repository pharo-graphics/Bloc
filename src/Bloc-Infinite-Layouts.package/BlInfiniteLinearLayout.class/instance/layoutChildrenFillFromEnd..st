layout
layoutChildrenFillFromEnd: anExtraSpace
	<return: #Point>
	| anExtraForStart anExtraForEnd aStartOffset anEndOffset aFirstElementPosition |

	anExtraForStart := anExtraSpace x.
	anExtraForEnd := anExtraSpace y.
	
	"fill towards start"
	self updateLayoutStateToFillStart: anchorInfo.
	layoutState extraSpace: anExtraForStart.
	self fillLayout: false.
	aStartOffset := layoutState offset.
	aFirstElementPosition := layoutState currentPosition.
	layoutState availableSpace > 0
		ifTrue: [ anExtraForEnd := anExtraForEnd + layoutState availableSpace ].
		
	"fill towards end"
	self updateLayoutStateToFillEnd: anchorInfo.
	layoutState extraSpace: anExtraForEnd.
	layoutState currentPosition: layoutState currentPosition + layoutState itemDirection multiplier.
	self fillLayout: false.
	anEndOffset := layoutState offset.
	layoutState availableSpace > 0
		ifTrue: [ 
			"end could not consume all. add more items towards start"
			anExtraForStart := layoutState availableSpace.
			self updateLayoutStateToFillStart: aFirstElementPosition offset: aStartOffset.
			layoutState extraSpace: anExtraForStart.
			self fillLayout: false.
			aStartOffset := layoutState offset	].
			
	^ aStartOffset @ anEndOffset