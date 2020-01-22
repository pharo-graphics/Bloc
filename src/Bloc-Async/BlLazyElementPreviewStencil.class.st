"
I represent an abstract preview stencil for ${class:BlLazyPreviewedElement}$. 
I am here more for documentation purposes as the ${method:BlLazyPreviewedElement>>#previewStencil:}$ can receive any stencil that understands the ${method:BrStencil>>#asElement|label=#selector}$ method.

See ${class:BlLazyPreviewedElement}$ and my subclasses for more details: ${class:BlLazyElementPreviewStencil|show=#gtSubclassesFor:|expanded=true|height=150}$
"
Class {
	#name : #BlLazyElementPreviewStencil,
	#superclass : #BrStencil,
	#category : #'Bloc-Async'
}

{ #category : #testing }
BlLazyElementPreviewStencil class >> isAbstract [
	^ self name = #BlLazyElementPreviewStencil 
]
