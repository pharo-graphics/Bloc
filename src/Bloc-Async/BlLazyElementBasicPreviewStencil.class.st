Class {
	#name : #BlLazyElementBasicPreviewStencil,
	#superclass : #BlLazyElementPreviewStencil,
	#category : #'Bloc-Async'
}

{ #category : #'api - instantiation' }
BlLazyElementBasicPreviewStencil >> create [
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
