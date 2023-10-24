Class {
	#name : #BlImageBackgroundBuilder,
	#superclass : #BlBackgroundBuilder,
	#instVars : [
		'form'
	],
	#category : 'Bloc-Basic-Background'
}

{ #category : #building }
BlImageBackgroundBuilder >> build [
	<return: #BlBackground>

	^ (BlImageBackground image: self form) opacity: self opacity
]

{ #category : #accessing }
BlImageBackgroundBuilder >> form [
	<return: #Form>

	^ form
]

{ #category : #accessing }
BlImageBackgroundBuilder >> form: aForm [
	form := aForm
]

{ #category : #accessing }
BlImageBackgroundBuilder >> iconNamed: aSymbol [
	self form: (Smalltalk ui icons iconNamed: aSymbol)
]
