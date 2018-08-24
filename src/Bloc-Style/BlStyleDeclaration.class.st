Class {
	#name : #BlStyleDeclaration,
	#superclass : #Object,
	#instVars : [
		'property',
		'important',
		'rule'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #'as yet unclassified' }
BlStyleDeclaration >> = aDeclaration [
	^ self property = aDeclaration property
]

{ #category : #'adding/removing' }
BlStyleDeclaration >> addTo: aRule [
	self subclassResponsibility 
]

{ #category : #accessing }
BlStyleDeclaration >> important [
	^ important
]

{ #category : #accessing }
BlStyleDeclaration >> important: anObject [
	important := anObject
]

{ #category : #'initialize-release' }
BlStyleDeclaration >> initialize [
	super initialize.
	important := false
]

{ #category : #testing }
BlStyleDeclaration >> isImportant [
	^ important
]

{ #category : #accessing }
BlStyleDeclaration >> property [
	^ property
]

{ #category : #accessing }
BlStyleDeclaration >> property: anObject [
	property := anObject
]

{ #category : #accessing }
BlStyleDeclaration >> rule [
	^ rule
]

{ #category : #accessing }
BlStyleDeclaration >> rule: anObject [
	rule := anObject
]
