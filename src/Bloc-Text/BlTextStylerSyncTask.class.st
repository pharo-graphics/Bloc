Class {
	#name : #BlTextStylerSyncTask,
	#superclass : #BlTextStylerTask,
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #styling }
BlTextStylerSyncTask >> style: aBrText afterDo: aBlock [
	^ self styler doStyle: aBrText afterDo: aBlock
]
