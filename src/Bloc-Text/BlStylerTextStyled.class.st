Class {
	#name : 'BlStylerTextStyled',
	#superclass : 'Announcement',
	#instVars : [
		'styledText'
	],
	#category : 'Bloc-Text-Text-Styler',
	#package : 'Bloc-Text',
	#tag : 'Text-Styler'
}

{ #category : 'text - styling' }
BlStylerTextStyled class >> styledText: aBlText [

	^ self new styledText: aBlText
]

{ #category : 'accessing' }
BlStylerTextStyled >> styledText [

	^ styledText
]

{ #category : 'accessing' }
BlStylerTextStyled >> styledText: aBlText [

	styledText := aBlText
]
