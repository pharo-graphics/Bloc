"
I inform that an element was attached to a scene. I can be added to any Bloc element.

"
Class {
	#name : #BlElementAddedToSceneGraphEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementAddedToSceneGraphEvent class >> disableIn: anObject [
	anObject disableAddedToSceneGraph
]

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
