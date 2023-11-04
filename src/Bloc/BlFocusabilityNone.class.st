Class {
	#name : 'BlFocusabilityNone',
	#superclass : 'BlFocusability',
	#package : 'Bloc',
	#tag : 'Basic-Properties'
}

{ #category : 'focus' }
BlFocusabilityNone >> focusables: anOrderedCollection along: aBlFocusSearchDirection of: anElement [
	"Add focusable elements that are descendants of a given element (possibly including anElement) to anOrderedCollection"
]
