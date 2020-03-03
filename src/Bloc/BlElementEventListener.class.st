Class {
	#name : #BlElementEventListener,
	#superclass : #BlEventListener,
	#category : #'Bloc-Events-Handler'
}

{ #category : #testing }
BlElementEventListener class >> isDeprecated [
	^ true
]

{ #category : #'element handlers' }
BlElementEventListener >> elementAddedToParentEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementAddedToSceneGraphEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementAddedToSuperParentEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementBackgroundChangedEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementBorderChangedEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementExtentChangedEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementLayoutChangedEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementPositionChangedEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementPositionInSpaceChangedEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementRemovedFromParentEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementRemovedFromSceneGraphEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementScrolledEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementSelectionAcquiredEvent: anEvent [
]

{ #category : #'element handlers' }
BlElementEventListener >> elementSelectionLostEvent: anEvent [
]

{ #category : #'api - accessing' }
BlElementEventListener >> eventsToHandle [
	^ super eventsToHandle, BlElementEvent allSubclasses
]
