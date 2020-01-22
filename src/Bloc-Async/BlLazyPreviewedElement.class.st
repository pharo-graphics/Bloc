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
	previewStencil := aBlLazyElementPreviewStencil
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
