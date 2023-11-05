Class {
	#name : 'BlCrosshairCursor',
	#superclass : 'BlNamedCursor',
	#category : 'Bloc-Space - Cursor'
}

{ #category : 'converting' }
BlCrosshairCursor >> asForm [
	^ Cursor crossHair
]
