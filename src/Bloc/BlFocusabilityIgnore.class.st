Class {
	#name : #BlFocusabilityIgnore,
	#superclass : #BlFocusability,
	#category : 'Bloc-Basic-Properties'
}

{ #category : 'focus' }
BlFocusabilityIgnore >> focusables: aBlFocusFinderCandidates along: aBlFocusSearchDirection of: anElement [
	"I ignore myself and only add children"

	anElement children
		select: [ :aChild | aChild isVisible ]
		thenDo: [ :aChild | aChild focusables: aBlFocusFinderCandidates along: aBlFocusSearchDirection ]
]
