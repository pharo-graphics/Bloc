"
# Attached space reference
Attached space reference `BlSpaceReference` is set when an element is `attached` to the scene graph.

"
Class {
	#name : #BlAttachedSpaceReference,
	#superclass : #BlSpaceReference,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Space'
}

{ #category : #cleanup }
BlAttachedSpaceReference class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlAttachedSpaceReference class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
BlAttachedSpaceReference >> isAttachedToSceneGraph [
	^ true
]
