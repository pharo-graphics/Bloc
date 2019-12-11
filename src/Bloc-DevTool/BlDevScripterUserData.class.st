Class {
	#name : #BlDevScripterUserData,
	#superclass : #Object,
	#instVars : [
		'dictionary'
	],
	#category : #'Bloc-DevTool-Scripter-Utilities'
}

{ #category : #accessing }
BlDevScripterUserData >> at: aSymbol [
	^ dictionary 
		at: aSymbol 
		ifAbsent: [ AssertionFailure signal: 'Scripter user data is not set: ', aSymbol printString ]
]

{ #category : #accessing }
BlDevScripterUserData >> at: aSymbol put: aValue [
	dictionary at: aSymbol put: aValue
]

{ #category : #'gt-extension' }
BlDevScripterUserData >> gtUserDataFor: aView [
	<gtView>
	dictionary ifNil: [ ^ aView empty ].
	^ (dictionary gtItemsFor: aView)
		title: 'User Data'
]

{ #category : #testing }
BlDevScripterUserData >> includesKey: aKey [ 
	^ dictionary includesKey: aKey
]

{ #category : #initialization }
BlDevScripterUserData >> initialize [
	super initialize.
	dictionary := Dictionary new.
]

{ #category : #testing }
BlDevScripterUserData >> isEmpty [
	^ dictionary isEmpty
]

{ #category : #accessing }
BlDevScripterUserData >> model [
	^ self at: #scripterModel
]

{ #category : #accessing }
BlDevScripterUserData >> model: anObject [
	^ self at: #scripterModel put: anObject
]
