layout
layoutChildrenFillFromStart: anExtraSpace
	<return: #Point>
	| anExtraForStart anExtraForEnd aStartOffset anEndOffset aLastElementPosition |

	anExtraForStart := anExtraSpace x.
	anExtraForEnd := anExtraSpace y.
	
	"fill towards end"
	self updateLayoutStateToFillEnd: anchorInfo.
	layoutState extraSpace: anExtraForEnd.
	self fillLayout: false.
	anEndOffset := layoutState offset. 
	aLastElementPosition := layoutState currentPosition.
	layoutState availableSpace > 0
		ifTrue: [ anExtraForStart := anExtraForStart + layoutState availableSpace ].
	
	"fill towards start"
	self updateLayoutStateToFillStart: anchorInfo.
	layoutState extraSpace: anExtraForStart.
	layoutState currentPosition: layoutState currentPosition + layoutState itemDirection multiplier.
	self fillLayout: false.
	aStartOffset := layoutState offset.
	layoutState availableSpace > 0
		ifTrue: [ 
			"end could not consume all. add more items towards start"
			anExtraForEnd := layoutState availableSpace.
			self updateLayoutStateToFillEnd: aLastElementPosition offset: anEndOffset.
			layoutState extraSpace: anExtraForEnd.
			self fillLayout: false.
			anEndOffset := layoutState offset	].
			
	^ aStartOffset @ anEndOffset