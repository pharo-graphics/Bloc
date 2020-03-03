"
I am used by ${class:BlSceneInformingElement}$ in ${method:BlSceneInformingElement>>#onAddedToSceneGraph|label=#selector}$.
I inform that an element was attached to a scene.

You can use ${class:BlElementAddedToSceneGraphEventHandler}$ to perform specific actions.
"
Class {
	#name : #BlElementAddedToSceneGraphEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementAddedToSceneGraphEvent class >> enableIn: anObject [
	anObject enableAddedToSceneGraph
]

{ #category : #'api - enable / disable' }
BlElementAddedToSceneGraphEvent class >> wantedIn: anObject [
	^ anObject wantsAddedToSceneGraph
]

{ #category : #sending }
BlElementAddedToSceneGraphEvent >> sendTo: anObject [
	anObject elementAddedToSceneGraphEvent: self
]
