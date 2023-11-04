"
I inform that an element was removed from a scene.  I can be added to any Bloc element.

"
Class {
	#name : 'BlElementRemovedFromSceneGraphEvent',
	#superclass : 'BlElementEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlElementRemovedFromSceneGraphEvent class >> disableIn: anObject [
	anObject disableRemovedFromSceneGraph
]

{ #category : 'api - enable / disable' }
BlElementRemovedFromSceneGraphEvent class >> enableIn: anObject [
	anObject enableRemovedFromSceneGraph
]

{ #category : 'api - enable / disable' }
BlElementRemovedFromSceneGraphEvent class >> wantedIn: anObject [
	^ anObject wantsRemovedFromSceneGraph
]

{ #category : 'sending' }
BlElementRemovedFromSceneGraphEvent >> sendTo: anObject [
	anObject elementRemovedFromSceneGraphEvent: self
]
