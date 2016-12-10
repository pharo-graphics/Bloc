layout
layoutChildrenFixGaps: anOffsetSpace
	"changes may cause gaps on the UI, try to fix them."
	<return: #Point>
	| aStartOffset anEndOffset |
	
	self hasChildren
		ifFalse: [ ^ anOffsetSpace ].

	aStartOffset := anOffsetSpace x.
	anEndOffset := anOffsetSpace y.
	
	"because layout from end may be changed by scroll to position
	we re-calculate it.
	ind which side we should check for gaps."
	
	shouldReverseLayout ~= stackFromEnd
		ifTrue: [ 
			| aFixOffset |
			aFixOffset := self fixLayoutEndGap: anEndOffset offsetChildren: true.
			aStartOffset := aStartOffset + aFixOffset.
			anEndOffset := anEndOffset + aFixOffset.
			aFixOffset := self fixLayoutStartGap: aStartOffset offsetChildren: false.
			aStartOffset := aStartOffset + aFixOffset.
			anEndOffset := anEndOffset + aFixOffset ]
		ifFalse: [ 
			| aFixOffset |
			aFixOffset := self fixLayoutStartGap: aStartOffset offsetChildren: true.
			aStartOffset := aStartOffset + aFixOffset.
			anEndOffset := anEndOffset + aFixOffset.
			aFixOffset := self fixLayoutEndGap: anEndOffset offsetChildren: false.
			aStartOffset := aStartOffset + aFixOffset.
			anEndOffset := anEndOffset + aFixOffset ].
	
	^ aStartOffset @ anEndOffset