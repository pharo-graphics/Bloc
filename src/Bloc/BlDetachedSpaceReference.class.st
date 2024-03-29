"
# Detached space reference
Detached space reference `BlSpaceReference` is set when an element is temporarily `detached` from the scene graph.

"
Class {
	#name : #BlDetachedSpaceReference,
	#superclass : #BlSpaceReference,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Space'
}

{ #category : #cleanup }
BlDetachedSpaceReference class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlDetachedSpaceReference class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
BlDetachedSpaceReference >> isDetachedFromSceneGraph [
	^ true
]
