Class {
	#name : 'BlCrosshairCursor',
	#superclass : 'BlNamedCursor',
	#category : 'Bloc-Space - Cursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlCrosshairCursor >> asForm [
	^ Cursor crossHair
]
