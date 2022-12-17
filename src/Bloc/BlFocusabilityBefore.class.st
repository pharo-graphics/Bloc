Class {
	#name : #BlFocusabilityBefore,
	#superclass : #BlFocusability,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #focus }
BlFocusabilityBefore >> focusables: aBlFocusFinderCandidates along: aBlFocusSearchDirection of: anElement [
	"anElement should get focus before descendants"

	anElement isFocusable
		ifTrue: [ aBlFocusFinderCandidates add: anElement ].
	
	anElement children
		select: [ :aChild | aChild isVisible ]
		thenDo: [ :aChild | aChild focusables: aBlFocusFinderCandidates along: aBlFocusSearchDirection ]
]
