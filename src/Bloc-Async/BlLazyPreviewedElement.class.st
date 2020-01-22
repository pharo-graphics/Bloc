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
	#instVars : [
		'previewStencil',
		'previewDelay'
	],
	#category : #'Bloc-Async'
}

{ #category : #initialization }
BlLazyPreviewedElement >> defaultPreviewDelay [
	^ 300 milliSeconds
]

{ #category : #initialization }
BlLazyPreviewedElement >> defaultPreviewStencil [
	^ BlLazyElementBasicPreviewStencil new
]

{ #category : #implementation }
BlLazyPreviewedElement >> displayProgress [
	"Conditionally display the progress element as my child.
	This must be executed by the UI process"

	self hasChildren ifTrue: [ ^ self ].

	self addChild: self previewStencil asElement.
]

{ #category : #implementation }
BlLazyPreviewedElement >> enqueueDisplayProgress [
	self enqueueTask: (BlTaskAction new action: [ self displayProgress ])
]

{ #category : #initialization }
BlLazyPreviewedElement >> initialize [
	super initialize.
	previewDelay := self defaultPreviewDelay.
	previewStencil := self defaultPreviewStencil.
]

{ #category : #'hooks - children' }
BlLazyPreviewedElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self schedulePreview.
]

{ #category : #accessing }
BlLazyPreviewedElement >> previewDelay [
	<return: #Duration>
	^ previewDelay
]

{ #category : #accessing }
BlLazyPreviewedElement >> previewDelay: aDuration [
	previewDelay := aDuration
]

{ #category : #accessing }
BlLazyPreviewedElement >> previewStencil [
	<return: #BlLazyElementPreviewStencil>
	^ previewStencil
]

{ #category : #accessing }
BlLazyPreviewedElement >> previewStencil: aBlLazyElementPreviewStencil [
	previewStencil := aBlLazyElementPreviewStencil asStencil
]

{ #category : #implementation }
BlLazyPreviewedElement >> schedulePreview [
	"schedule a preview display"
	BlUseAsyncFeatures 
		ifEnabledDo: [ 
			BlTaskAtQueue default
				schedule: [ self enqueueDisplayProgress ]
				at: self space time now + self previewDelay ]
			otherwise: [ self displayProgress ]
]
