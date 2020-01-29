"
I can be attached to ${class:BlSceneInformingElement}$.
I listen to ${class:BlElementAddedToSceneGraphEvent}$ events and perform ${method:BlSceneInformingEventHandler>>#valuable|label=#selector}$ actions.

"
Class {
	#name : #BlElementAddedToSceneGraphEventHandler,
	#superclass : #BlSceneInformingEventHandler,
	#category : #'Bloc-Events-Handling'
}

{ #category : #accessing }
BlElementAddedToSceneGraphEventHandler >> eventClass [
	^ BlElementAddedToSceneGraphEvent
]
