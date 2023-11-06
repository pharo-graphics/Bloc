Class {
	#name : 'BlWaitCursor',
	#superclass : 'BlNamedCursor',
	#category : 'Bloc-Space - Cursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlWaitCursor >> asForm [
	^ Cursor wait
]
