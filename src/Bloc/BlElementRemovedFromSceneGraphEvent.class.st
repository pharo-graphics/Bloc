"
I am used by ${class:BlSceneInformingElement}$ in ${method:BlSceneInformingElement>>#onRemovedFromSceneGraph|label=#selector}$.
I inform that an element was removed from a scene.

You can use ${class:BlElementRemovedFromSceneGraphEvent}$ to perform specific actions.
"
Class {
	#name : #BlElementRemovedFromSceneGraphEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementRemovedFromSceneGraphEvent class >> enableIn: anObject [
	anObject enableRemovedFromSceneGraph
]

{ #category : #'api - enable / disable' }
BlElementRemovedFromSceneGraphEvent class >> wantedIn: anObject [
	^ anObject wantsRemovedFromSceneGraph
]

{ #category : #sending }
BlElementRemovedFromSceneGraphEvent >> sendTo: anObject [
	anObject elementRemovedFromSceneGraphEvent: self
]
