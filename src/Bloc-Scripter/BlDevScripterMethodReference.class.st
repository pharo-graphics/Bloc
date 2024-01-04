Class {
	#name : #BlDevScripterMethodReference,
	#superclass : #BlDevScripterReference,
	#instVars : [
		'definition'
	],
	#category : 'Bloc-Scripter-Scripter-Properties'
}

{ #category : #accessing }
BlDevScripterMethodReference >> definition [
	^ definition
]

{ #category : #accessing }
BlDevScripterMethodReference >> definition: anObject [
	definition := anObject
]

{ #category : #enumerating }
BlDevScripterMethodReference >> definitionDo: aBlock [
	aBlock value: self definition
]
