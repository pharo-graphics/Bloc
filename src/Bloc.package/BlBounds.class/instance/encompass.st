accessing
encompass
	| newLeft newTop newRight newBottom |
	
	newLeft := left min: right.
	newTop := top min: bottom.
	newRight := left max: right.
	newBottom := top max: bottom.
	
	left := newLeft.
	top := newTop.
	right := newRight.
	bottom := newBottom