"
I am used by ${class:BlSceneInformingElement}$ in ${method:BlSceneInformingElement>>#onRemovedFromSceneGraph|label=#selector}$.
I inform that an element was removed from a scene.

You can use ${class:BlElementRemovedFromSceneGraphEvent}$ to perform specific actions.
"
Class {
	#name : #BlElementRemovedFromSceneGraphEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Events-Element'
}

{ #category : #'api - enable / disable' }
BlElementRemovedFromSceneGraphEvent class >> enableIn: anObject [
	anObject enableRemovedFromSceneGraph
]

{ #category : #'api - enable / disable' }
BlElementRemovedFromSceneGraphEvent class >> wantedIn: anObject [
	^ anObject wantsRemovedFromSceneGraph
]

{ #category : #accessing }
BlElementRemovedFromSceneGraphEvent >> element [
	^ element
]

{ #category : #accessing }
BlElementRemovedFromSceneGraphEvent >> element: anObject [
	element := anObject
]
