Class {
	#name : #BlWeakRef,
	#superclass : #WeakArray,
	#type : #weak,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Basic-Support'
}

{ #category : #'as yet unclassified' }
BlWeakRef class >> new [
	^ self new: 1
]

{ #category : #'as yet unclassified' }
BlWeakRef >> value [
	^ self at: 1 ifAbsent: [ nil ]
]

{ #category : #'as yet unclassified' }
BlWeakRef >> value: anObject [
	self at:1 put: anObject
]
