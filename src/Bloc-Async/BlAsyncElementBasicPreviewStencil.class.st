"
I represent a basic preview stencil for ${class:BlAsyncDelayedPreviewStrategy}$. 

I generate the following preview: ${example:BlAsyncElementExamples>>#previewStencil|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #BlAsyncElementBasicPreviewStencil,
	#superclass : #BlAsyncElementPreviewStencil,
	#category : #'Bloc-Async'
}

{ #category : #'api - instantiation' }
BlAsyncElementBasicPreviewStencil >> create [
	^ BlElement new
		layout: BlFrameLayout new;
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent. ];
		addChild: (BlTextElement new
			text: ('Preparing...' asRopedText foreground: Color veryLightGray);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent.
				c frame vertical alignCenter.
				c frame horizontal alignCenter ])
]
