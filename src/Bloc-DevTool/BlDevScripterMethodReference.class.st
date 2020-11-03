Class {
	#name : #BlDevScripterMethodReference,
	#superclass : #BlDevScripterReference,
	#instVars : [
		'definition'
	],
	#category : #'Bloc-DevTool-Scripter-Properties'
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

{ #category : #'gt-extension' }
BlDevScripterMethodReference >> gtReferenceFor: aView [
	<gtView>
	self definition ifNil: [ ^ aView empty ].
	^ self definition gtSourceFor: aView
]
