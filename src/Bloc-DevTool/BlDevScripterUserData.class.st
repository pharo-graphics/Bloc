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
	^ dictionary at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
BlDevScripterUserData >> at: aSymbol put: aValue [
	dictionary at: aSymbol put: aValue
]

{ #category : #initialization }
BlDevScripterUserData >> initialize [
	super initialize.
	dictionary := Dictionary new.
]
