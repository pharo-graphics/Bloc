"
I am a ${class:BlAsyncElement}$ preview strategy.
I know how to render a preview that is displayed while waiting to calculate an expected ${class:BlElement}$.

My subclasses needs to implement ${method:BlAsyncPreviewStrategy>>#schedulePreviewIn:}$.

See my subclasses for more details: ${class:BlAsyncPreviewStrategy|show=#gtSubclassesFor:|height=150|expanded=true}$

"
Class {
	#name : #BlAsyncPreviewStrategy,
	#superclass : #Object,
	#category : #'Bloc-Async'
}

{ #category : #factory }
BlAsyncPreviewStrategy class >> delayedStencil: aStencil [
	^ BlAsyncDelayedPreviewStrategy new previewStencil: aStencil
]

{ #category : #factory }
BlAsyncPreviewStrategy class >> null [
	^ BlAsyncNoPreviewStrategy default
]

{ #category : #scheduling }
BlAsyncPreviewStrategy >> schedulePreviewIn: anElement [
	"schedule a preview and add it to the anElement"
	self subclassResponsibility
]
