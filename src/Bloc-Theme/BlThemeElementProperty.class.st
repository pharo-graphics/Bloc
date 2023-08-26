Class {
	#name : #BlThemeElementProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'theme'
	],
	#category : #'Bloc-Theme'
}

{ #category : #accessing }
BlThemeElementProperty >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ theme = anObject theme
]

{ #category : #accessing }
BlThemeElementProperty >> applyOnElement: anElement [
	anElement userData at: #BlTheme put: theme.	
]

{ #category : #accessing }
BlThemeElementProperty >> canPropagateToChildren [
	^ true
]

{ #category : #accessing }
BlThemeElementProperty >> hash [
	^ theme hash
]

{ #category : #accessing }
BlThemeElementProperty >> theme [
	^ theme
]

{ #category : #accessing }
BlThemeElementProperty >> theme: aTheme [
	theme := aTheme
]
