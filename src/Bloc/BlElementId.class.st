"
! Element id

Allows to assign id to ${class:BlElement}$. This allows us query a tree of elements
"
Class {
	#name : #BlElementId,
	#superclass : #Object,
	#category : #'Bloc-Basic-Support'
}

{ #category : #'instance creation' }
BlElementId class >> named: aSymbol [
	^ BlElementNamedId new
		identifier: aSymbol asSymbol
]

{ #category : #'instance creation' }
BlElementId class >> noId [
	^ BlElementNoId uniqueInstance
]

{ #category : #converting }
BlElementId >> asBlocElementId [
	^ self
]

{ #category : #converting }
BlElementId >> asSymbol [
	^ self subclassResponsibility
]

{ #category : #printing }
BlElementId >> printOn: aStream [
	self class isAbstract
		ifTrue: [ aStream print: self ]
		ifFalse: [ aStream print: self asSymbol ]
]
