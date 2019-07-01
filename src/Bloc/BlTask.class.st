Class {
	#name : #BlTask,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Space-Support'
}

{ #category : #hooks }
BlTask >> onEnqueued: aBlSpace [
	"Is self when a task is enqueued in a space.
	It gives subclasses a possibility to synchronize time with the space"
]

{ #category : #hooks }
BlTask >> onEnqueuedInElement: aBlElement [
	"Is sent when a task is enqueued in a element.
	It gives subclasses a possibility to re-enqueue themselves in the same element"
]

{ #category : #'api - running' }
BlTask >> run [
	self subclassResponsibility
]

{ #category : #'api - running' }
BlTask >> value [
	"To support defer:"
	self run
]
