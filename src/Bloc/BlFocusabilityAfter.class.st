Class {
	#name : #BlFocusabilityAfter,
	#superclass : #BlFocusability,
	#category : 'Bloc-Basic-Properties'
}

{ #category : #focus }
BlFocusabilityAfter >> focusables: aBlFocusFinderCandidates along: aBlFocusSearchDirection of: anElement [
	"We always add visible children and skip anElement itself if there are focusable descendants"
	| focusablesCount |

	"store how many focusable element we have in collection before adding children
	in order to compare with later and check if we need to add anElement"
	focusablesCount := aBlFocusFinderCandidates size.
	
	anElement children
		select: [ :aChild | aChild isVisible ]
		thenDo: [ :aChild | aChild focusables: aBlFocusFinderCandidates along: aBlFocusSearchDirection ].
		
	(anElement isFocusable and: [ focusablesCount = aBlFocusFinderCandidates size ])
		ifTrue: [ aBlFocusFinderCandidates add: anElement ]
]
