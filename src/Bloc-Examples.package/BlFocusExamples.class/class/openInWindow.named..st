opening
openInWindow: anElement named: aTitleString
	| aSpace |
		
	aSpace := BlSpace new
		title: aTitleString.

	aSpace root
		addChild: anElement;
		yourself.

	aSpace pulse.
	aSpace extent: anElement extent.
	
	aSpace show