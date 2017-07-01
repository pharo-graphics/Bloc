focus accessing
focusables: anOrderedCollection along: aBlFocusSearchDirection
	"Add focusable elements that are descendants of this element (possibly including me) to anOrderedCollection.
	I only add visible and focusable elements"

	self children
		select: [ :anElement | anElement isVisible ]
		thenDo: [ :anElement | anElement focusables: anOrderedCollection along: aBlFocusSearchDirection ].
		
	self isFocusable
		ifTrue: [ anOrderedCollection add: self ]