Class {
	#name : #BlDefaultStatusTheme,
	#superclass : #BlTheme,
	#instVars : [
		'successBackgroundColor',
		'successBorderColor',
		'neutralBackgroundColor',
		'errorBorderColor',
		'errorBackgroundColor',
		'failureBorderColor',
		'paleErrorBackgroundColor',
		'failureBackgroundColor'
	],
	#category : #'Bloc-Theme'
}

{ #category : #initialization }
BlDefaultStatusTheme class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
BlDefaultStatusTheme >> errorBackgroundColor [
	^ errorBackgroundColor
]

{ #category : #accessing }
BlDefaultStatusTheme >> errorBackgroundColor: anObject [
	errorBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultStatusTheme >> errorBorderColor [
	^ errorBorderColor
]

{ #category : #accessing }
BlDefaultStatusTheme >> errorBorderColor: anObject [
	errorBorderColor := anObject
]

{ #category : #accessing }
BlDefaultStatusTheme >> failureBackgroundColor [
	^ failureBackgroundColor
]

{ #category : #accessing }
BlDefaultStatusTheme >> failureBackgroundColor: anObject [
	failureBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultStatusTheme >> failureBorderColor [
	^ failureBorderColor
]

{ #category : #accessing }
BlDefaultStatusTheme >> failureBorderColor: anObject [
	failureBorderColor := anObject
]

{ #category : #initialization }
BlDefaultStatusTheme >> initialize [
	super initialize.
	successBackgroundColor := BlDefaultColors successBackgroundColor.
	successBorderColor := BlDefaultColors successBorderColor.
	neutralBackgroundColor := BlDefaultColors neutralBackgroundColor.
	errorBorderColor := BlDefaultColors errorBorderColor.
	errorBackgroundColor := BlDefaultColors errorBackgroundColor.
	failureBorderColor := BlDefaultColors failureBorderColor.
	paleErrorBackgroundColor := BlDefaultColors
		paleErrorBackgroundColor.
	failureBackgroundColor := BlDefaultColors failureBackgroundColor
]

{ #category : #accessing }
BlDefaultStatusTheme >> neutralBackgroundColor [
	^ neutralBackgroundColor
]

{ #category : #accessing }
BlDefaultStatusTheme >> neutralBackgroundColor: anObject [
	neutralBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultStatusTheme >> paleErrorBackgroundColor [
	^ paleErrorBackgroundColor
]

{ #category : #accessing }
BlDefaultStatusTheme >> paleErrorBackgroundColor: anObject [
	paleErrorBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultStatusTheme >> successBackgroundColor [
	^ successBackgroundColor
]

{ #category : #accessing }
BlDefaultStatusTheme >> successBackgroundColor: anObject [
	successBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultStatusTheme >> successBorderColor [
	^ successBorderColor
]

{ #category : #accessing }
BlDefaultStatusTheme >> successBorderColor: anObject [
	successBorderColor := anObject
]
