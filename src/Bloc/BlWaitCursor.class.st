Class {
	#name : #BlWaitCursor,
	#superclass : #BlNamedCursor,
	#category : #'Bloc-Space - Cursor'
}

{ #category : #converting }
BlWaitCursor >> asForm [
	^ Cursor wait
]
