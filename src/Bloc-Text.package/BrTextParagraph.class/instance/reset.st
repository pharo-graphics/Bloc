initialization
reset
	self wantsAutoRelease
		ifFalse: [ self finalize ].

	text := nil.
	maxHeight := Float infinity.
	maxWidth := Float infinity.
	height := 0.
	width := 0.
	end := 0.
	autoRelease := true.
	selection := (0 to: 0) "empty selection"