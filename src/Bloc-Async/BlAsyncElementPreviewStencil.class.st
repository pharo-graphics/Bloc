"
I represent an abstract preview stencil for ${class:BlAsyncDelayedPreviewStrategy}$. 
I am here more for documentation purposes as the ${method:BlAsyncDelayedPreviewStrategy>>#previewStencil:}$ can receive any stencil that understands the ${method:BrStencil>>#asElement|label=#selector}$ method.
 
See ${class:BlAsyncDelayedPreviewStrategy}$ and my subclasses for more details: ${class:BlAsyncElementPreviewStencil|show=#gtSubclassesFor:|expanded=true|height=150}$
"
Class {
	#name : #BlAsyncElementPreviewStencil,
	#superclass : #BrStencil,
	#category : #'Bloc-Async'
}

{ #category : #testing }
BlAsyncElementPreviewStencil class >> isAbstract [
	^ self name = #BlAsyncElementPreviewStencil 
]
