"
I inform that an element was attached to a scene. I can be added to any Bloc element.

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

{ #category : #visiting }
BlElementAddedToSceneGraphEvent >> accept: aVisitor [
	^ aVisitor visitElementAddedToSceneGraphEvent: self
]

{ #category : #sending }
BlElementAddedToSceneGraphEvent >> sendTo: anObject [
	anObject elementAddedToSceneGraphEvent: self
]
