focus
nextFocus: aFocusedElement in: aCollectionOfElements within: aFocusRootElement from: aFocusedBounds finder: aFocusFinder
	<return: #BlElement or: nil>
	| bestCandidateBounds tempBounds closestElement |
	
	bestCandidateBounds := aFocusFinder bestCandidateBounds.
	tempBounds := aFocusFinder temporaryBounds.
	
	bestCandidateBounds bounds: aFocusedBounds.
	self offsetCandidateBounds: bestCandidateBounds according: aFocusedBounds.
	
	closestElement := nil.
	
	aCollectionOfElements do: [ :anElement |
		"we are only interested in elements that are not root or given focused element"
		(anElement == aFocusedElement or: [ anElement == aFocusRootElement ])
			ifFalse: [
				anElement focusedBounds: tempBounds.
				aFocusRootElement childBounds: tempBounds toLocal: anElement.
				
				(self isBetterCandidate: tempBounds then: bestCandidateBounds in: aFocusedBounds)
					ifTrue: [ 
						bestCandidateBounds bounds: tempBounds.
						closestElement := anElement ] ] ].
			
	^ closestElement