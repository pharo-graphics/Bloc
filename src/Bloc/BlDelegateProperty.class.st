Class {
	#name : #BlDelegateProperty,
	#superclass : #BlObjectProperty,
	#instVars : [
		'property',
		'delegationBlock'
	],
	#category : 'Bloc-Property'
}

{ #category : #'as yet unclassified' }
BlDelegateProperty class >> on: anOwner named: aSymbol delegateTo: aProperty [ 
	^ self new
		name: aSymbol;
		owner: anOwner;
		delegateTo: aProperty;
		yourself
]

{ #category : #'as yet unclassified' }
BlDelegateProperty class >> on: anOwner named: aSymbol delegateTo: aProperty do: aDelegationBlock [
	^ self new
		name: aSymbol;
		owner: anOwner;
		delegateTo: aProperty;
		do: aDelegationBlock;
		yourself
]

{ #category : #delegation }
BlDelegateProperty >> delegateTo: aProperty [
	aProperty addChangeListener: self.
	property := aProperty.
	
]

{ #category : #enumerating }
BlDelegateProperty >> do: aDelegationBlock [
	delegationBlock := aDelegationBlock
]

{ #category : #accessing }
BlDelegateProperty >> initialize [
	super initialize.
	delegationBlock := [ :p :v | 
		(p perform: self name) = v ifFalse: [
			p perform: self name asMutator with: v ] ]
]

{ #category : #'change management' }
BlDelegateProperty >> invalidated [
	property value ifNotNil: [ :o | delegationBlock value: o value: self rawValue ]
]

{ #category : #accessing }
BlDelegateProperty >> valueChanged: anObject [
	anObject ifNil:[^ self].
	delegationBlock value: anObject value: self rawValue
]
