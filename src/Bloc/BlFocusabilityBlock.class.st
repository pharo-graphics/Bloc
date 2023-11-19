Class {
	#name : 'BlFocusabilityBlock',
	#superclass : 'BlFocusability',
	#category : 'Bloc-Basic-Properties',
	#package : 'Bloc',
	#tag : 'Basic-Properties'
}

{ #category : 'focus' }
BlFocusabilityBlock >> focusables: anOrderedCollection along: aBlFocusSearchDirection of: anElement [
	"Block descendants and only add anElement"

	anElement isFocusable
		ifTrue: [ anOrderedCollection add: anElement ]
]
