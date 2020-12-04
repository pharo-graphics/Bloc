Class {
	#name : #BlElementDynamicProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #accessing }
BlElementDynamicProperty >> action [
	^ action
]

{ #category : #accessing }
BlElementDynamicProperty >> action: anObject [
	action := anObject
]

{ #category : #'api - property' }
BlElementDynamicProperty >> applyOnElement: anElement [
	self action cull: anElement
]

{ #category : #generated }
BlElementDynamicProperty >> type [
	^ self action
]
