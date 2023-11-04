Class {
	#name : #BlNamedCursor,
	#superclass : #BlCursor,
	#category : #'Bloc-Space - Cursor'
}

{ #category : #converting }
BlNamedCursor >> asForm [
	^ Form extent: 1@1 depth: 32
]
