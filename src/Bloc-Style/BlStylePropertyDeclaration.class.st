Class {
	#name : #BlStylePropertyDeclaration,
	#superclass : #BlStyleDeclaration,
	#instVars : [
		'value'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #'as yet unclassified' }
BlStylePropertyDeclaration >> = aDeclaration [
	^ super = aDeclaration and: [ self value = aDeclaration value ]
]

{ #category : #'adding/removing' }
BlStylePropertyDeclaration >> addTo: aRule [
	aRule declarations add: self
]

{ #category : #printing }
BlStylePropertyDeclaration >> printOn: aStream [
	aStream
		nextPutAll: self property;
		nextPutAll: ': ';
		nextPutAll: self value asString.
	self isImportant
		ifTrue: [ aStream nextPutAll: '!important' ]
]

{ #category : #accessing }
BlStylePropertyDeclaration >> value [
	^ value
]

{ #category : #accessing }
BlStylePropertyDeclaration >> value: anObject [
	value := anObject
]
