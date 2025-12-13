"
I represent the identifier of an `BlElement`. This allows query a tree of elements.

"
Class {
	#name : #BlElementId,
	#superclass : #Object,
	#category : #'Bloc-Basic-Support'
}

{ #category : #'instance creation' }
BlElementId class >> named: aString [

	^ BlElementNamedId new
		  name: aString asSymbol;
		  yourself
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

{ #category : #comparing }
BlElementId >> hash [
	"Hash must always be based on the symbolm to support proper comparison between ids that are just
	constructed differently but have same symbolic id"

	^ self asSymbol hash
]

{ #category : #converting }
BlElementId >> indexed: anIndex [
	"Answer a new indexed id with me as prefix and the given index as suffix"

	^ BlElementIndexedId new
		prefixId: self;
		index: anIndex;
		yourself
]

{ #category : #converting }
BlElementId >> isBlocElementId [

	^ true
]

{ #category : #testing }
BlElementId >> isIndexed [

	^ false
]

{ #category : #testing }
BlElementId >> isNoId [

	^ false
]

{ #category : #printing }
BlElementId >> printOn: aStream [

	self class isAbstract
		ifTrue: [ aStream print: self ]
		ifFalse: [ aStream print: self asSymbol ]
]
