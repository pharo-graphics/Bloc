"
I am a ${class:BlAsyncElement}$ preview strategy.
I postpone a preview by a given ${method:BlAsyncDelayedPreviewStrategy>>#previewDelay|label=#selector}$ time. The default time is set in ${method:BlAsyncDelayedPreviewStrategy>>#defaultPreviewDelay|label=#selector}$ to ${example:BlAsyncElementExamples>>#asyncDelayedPreviewStrategyDelay|label=#yourself}$. 

I know how to render a preview which is displayed while waiting to calculate the desired ${class:BlElement}$.
I use ${class:BlAsyncElementPreviewStencil}$ to render a preview ${class:BlElement}$ object.

!! Preview Element 

The following example display a preview for about 3 seconds:
${example:BlAsyncElementExamples>>#lazyPreviewedElement|codeExpanded=true|previewExpanded=false}$

!! Preview Stencil 

This is the preview that was visible shortly in the example above:
${example:BlAsyncElementExamples>>#previewStencil|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #BlAsyncDelayedPreviewStrategy,
	#superclass : #BlAsyncPreviewStrategy,
	#instVars : [
		'previewStencil',
		'previewDelay'
	],
	#category : #'Bloc-Async'
}

{ #category : #initialization }
BlAsyncDelayedPreviewStrategy >> defaultPreviewDelay [
	^ 300 milliSeconds
]

{ #category : #initialization }
BlAsyncDelayedPreviewStrategy >> defaultPreviewStencil [
	^ BlLazyElementBasicPreviewStencil new
]

{ #category : #implementation }
BlAsyncDelayedPreviewStrategy >> displayProgressIn: anElement [
	"Conditionally display the progress element as my child.
	This must be executed by the UI process"

	anElement hasChildren ifTrue: [ ^ self ].

	anElement addChild: self previewElement.
]

{ #category : #implementation }
BlAsyncDelayedPreviewStrategy >> enqueueDisplayProgressIn: anElement [
	anElement enqueueTask: (BlTaskAction new action: [ self displayProgressIn: anElement ])
]

{ #category : #initialization }
BlAsyncDelayedPreviewStrategy >> initialize [
	super initialize.
	previewDelay := self defaultPreviewDelay.
	previewStencil := self defaultPreviewStencil.
]

{ #category : #accessing }
BlAsyncDelayedPreviewStrategy >> previewDelay [
	<return: #Duration>
	^ previewDelay
]

{ #category : #accessing }
BlAsyncDelayedPreviewStrategy >> previewDelay: aDuration [
	previewDelay := aDuration
]

{ #category : #implementation }
BlAsyncDelayedPreviewStrategy >> previewElement [
	<return: #BlElement>
	^ self previewStencil asElement
]

{ #category : #accessing }
BlAsyncDelayedPreviewStrategy >> previewStencil [
	<return: #BlAsyncElementPreviewStencil>
	^ previewStencil
]

{ #category : #accessing }
BlAsyncDelayedPreviewStrategy >> previewStencil: aBlLazyElementPreviewStencil [
	previewStencil := aBlLazyElementPreviewStencil asStencil
]

{ #category : #scheduling }
BlAsyncDelayedPreviewStrategy >> schedulePreviewIn: anElement [
	"do nothing"
	BlUseAsyncFeatures 
		ifEnabledDo: [ 
			| aNow |
			aNow := anElement space 
				ifNotNil: [ :aSpace | aSpace time now ] 
				ifNil: [ BlTime real now ].
			BlTaskAtQueue default
				schedule: [ self enqueueDisplayProgressIn: anElement ]
				at: aNow + self previewDelay ]
			otherwise: [ self displayProgressIn: anElement ]
]
