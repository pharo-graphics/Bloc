Class {
	#name : 'BlCrosshairCursor',
	#superclass : 'BlNamedCursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlCrosshairCursor >> asForm [
	^ Cursor crossHair
]
