private - focus
nextFocus: aFocusedElement in: aCollectionOfElements within: aFocusRootElement from: aFocusedBounds along: aBlFocusSearchDirection
	| requestedFocusedBounds |
	
	requestedFocusedBounds := aFocusedBounds.
	
	aFocusedElement
		ifNotNil: [
			requestedFocusedBounds
				ifNil: [ requestedFocusedBounds := focusedBounds ].
			aFocusedElement focusedBounds: requestedFocusedBounds.
			aFocusRootElement childBounds: requestedFocusedBounds toLocal: aFocusedElement ]
		ifNil: [
			requestedFocusedBounds := aFocusedBounds.
			requestedFocusedBounds
				ifNil: [
					requestedFocusedBounds := focusedBounds.
					aBlFocusSearchDirection initFocusedBounds: requestedFocusedBounds root: aFocusRootElement ] ].
		
	^ aBlFocusSearchDirection
		nextFocus: aFocusedElement
		in: aCollectionOfElements
		within: aFocusRootElement
		from: requestedFocusedBounds
		finder: self