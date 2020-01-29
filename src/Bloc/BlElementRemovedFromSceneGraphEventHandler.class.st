"
I can be attached to ${class:BlSceneInformingElement}$.
I listen to ${class:BlElementRemovedFromSceneGraphEvent}$ events and perform ${method:BlSceneInformingEventHandler>>#valuable|label=#selector}$ actions.

"
Class {
	#name : #BlElementRemovedFromSceneGraphEventHandler,
	#superclass : #BlSceneInformingEventHandler,
	#category : #'Bloc-Events-Handling'
}

{ #category : #accessing }
BlElementRemovedFromSceneGraphEventHandler >> eventClass [
	^ BlElementRemovedFromSceneGraphEvent
]
