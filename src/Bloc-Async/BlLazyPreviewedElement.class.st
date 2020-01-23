"
I am a lazy element that extends the ${class:BlLazyElement}$ behavior.
I know how to render a preview which is displayed while waiting to calculate the desired ${class:BlElement}$.
I use ${class:BlLazyElementPreviewStencil}$ to render a preview ${class:BlElement}$ object.

!! Preview Element 

The following example display a preview for about 3 seconds:
${example:BlAsyncElementExamples>>#lazyPreviewedElement|codeExpanded=true|previewExpanded=false}$

!! Preview Stencil 

This is the preview that was visible shortly in the example above:
${example:BlAsyncElementExamples>>#previewStencil|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #BlLazyPreviewedElement,
	#superclass : #BlLazyElement,
	#category : #'Bloc-Async'
}

{ #category : #testing }
BlLazyPreviewedElement class >> isDeprecated [
	^ true
]

{ #category : #accessing }
BlLazyPreviewedElement >> previewStencil: aStencil [
	self previewStrategy: (BlAsyncDelayedPreviewStrategy new previewStencil: aStencil).
]
