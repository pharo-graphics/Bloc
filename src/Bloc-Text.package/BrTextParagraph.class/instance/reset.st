initialization
reset
	self wantsAutoRelease
		ifFalse: [ self finalize ].

	text := nil.
	maxHeight := Float infinity.
	maxWidth := Float infinity.
	end := 0.
	autoRelease := true.
	selection := nil.
	containerExtent := 0@0.
	baseline := BrTextParagraphAscentBaseline uniqueInstance