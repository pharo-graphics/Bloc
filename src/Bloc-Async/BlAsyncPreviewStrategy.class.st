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
