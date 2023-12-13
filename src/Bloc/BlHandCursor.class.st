Class {
	#name : #BlHandCursor,
	#superclass : #BlNamedCursor,
	#category : 'Bloc-Space - Cursor'
}

{ #category : #converting }
BlHandCursor >> asForm [
	^ Cursor webLink
]
