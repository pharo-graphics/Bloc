private - focus
nextFocus: aFocusedElement within: aFocusRootElement from: aFocusedBounds along: aBlFocusSearchDirection
	| theFocusables nextFocus |
	
	nextFocus := nil.
	theFocusables := OrderedCollection new.
	
	aFocusRootElement focusables: theFocusables along: aBlFocusSearchDirection.
	theFocusables ifNotEmpty: [ 
		nextFocus := self
			nextFocus: aFocusedElement
			in: theFocusables
			within: aFocusRootElement
			from: aFocusedBounds
			along: aBlFocusSearchDirection ].
	
	
	^ nextFocus