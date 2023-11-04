Class {
	#name : #BlDefaultLinkTheme,
	#superclass : #BlTheme,
	#instVars : [
		'color',
		'errorColor'
	],
	#category : #'Bloc-Theme'
}

{ #category : #accessing }
BlDefaultLinkTheme >> color [
	^ color
]

{ #category : #accessing }
BlDefaultLinkTheme >> color: anObject [
	color := anObject
]

{ #category : #accessing }
BlDefaultLinkTheme >> errorColor [
	^ errorColor
]

{ #category : #accessing }
BlDefaultLinkTheme >> errorColor: anObject [
	errorColor := anObject
]

{ #category : #initialization }
BlDefaultLinkTheme >> initialize [
	super initialize.
	color := BlDefaultColors linkColor.
	errorColor := BlDefaultColors linkWithErrorColor
]
