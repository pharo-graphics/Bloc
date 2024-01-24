Class {
	#name : #BlDefaultEditorTheme,
	#superclass : #BlTheme,
	#instVars : [
		'borderColor',
		'focusedBorderColor'
	],
	#category : #'Bloc-Deprecated-Theme'
}

{ #category : #initialization }
BlDefaultEditorTheme class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
BlDefaultEditorTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
BlDefaultEditorTheme >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #accessing }
BlDefaultEditorTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
BlDefaultEditorTheme >> focusedBorderColor: anObject [
	focusedBorderColor := anObject
]

{ #category : #initialization }
BlDefaultEditorTheme >> initialize [
	super initialize.
	borderColor := BlDefaultColors editorBorderColor.
	focusedBorderColor := BlDefaultColors focusedEditorBorderColor
]
