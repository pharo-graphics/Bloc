Class {
	#name : 'BlWaitCursor',
	#superclass : 'BlNamedCursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlWaitCursor >> asForm [
	^ Cursor wait
]
