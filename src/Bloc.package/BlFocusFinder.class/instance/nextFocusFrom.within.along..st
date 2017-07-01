focus
nextFocusFrom: aFocusedBounds within: aFocusRootElement along: aBlFocusSearchDirection
	
	focusedBounds bounds: aFocusedBounds.
	^ self
		nextFocus: nil
		within: aFocusRootElement
		from: focusedBounds
		along: aBlFocusSearchDirection