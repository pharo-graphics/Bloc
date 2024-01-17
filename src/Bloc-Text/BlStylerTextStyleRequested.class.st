Class {
	#name : 'BlStylerTextStyleRequested',
	#superclass : 'Announcement',
	#instVars : [
		'unstyledText',
		'referentElement'
	],
	#category : 'Bloc-Text-Text-Styler',
	#package : 'Bloc-Text',
	#tag : 'Text-Styler'
}

{ #category : 'accessing' }
BlStylerTextStyleRequested >> referentElement [

	^ referentElement
]

{ #category : 'accessing' }
BlStylerTextStyleRequested >> referentElement: anObject [

	referentElement := anObject
]

{ #category : 'accessing' }
BlStylerTextStyleRequested >> unstyledText [

	^ unstyledText
]

{ #category : 'accessing' }
BlStylerTextStyleRequested >> unstyledText: anObject [

	unstyledText := anObject
]
