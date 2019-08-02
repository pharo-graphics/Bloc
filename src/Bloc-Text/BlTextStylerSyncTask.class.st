"
I do style all text in the same active process.
In other words, I do not spawn any background processes.

I am used by ${class:BlTextStyler}$.
"
Class {
	#name : #BlTextStylerSyncTask,
	#superclass : #BlTextStylerTask,
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #styling }
BlTextStylerSyncTask >> style: aBrText afterDo: aBlock [
	^ self styler doStyle: aBrText afterDo: aBlock
]
