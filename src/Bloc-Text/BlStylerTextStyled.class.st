Class {
	#name : #BlStylerTextStyled,
	#superclass : #Announcement,
	#instVars : [
		'textStyled'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #'text - styling' }
BlStylerTextStyled class >> textStyled: aBlText [

	^ self new textStyled: aBlText
]

{ #category : #accessing }
BlStylerTextStyled >> textStyled [

	^ textStyled
]

{ #category : #accessing }
BlStylerTextStyled >> textStyled: aBlText [

	textStyled := aBlText
]
