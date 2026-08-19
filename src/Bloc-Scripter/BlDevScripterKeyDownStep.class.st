Class {
	#name : #BlDevScripterKeyDownStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyDownStep >> defaultLabel [
	^ 'Key down'
]

{ #category : #actions }
BlDevScripterKeyDownStep >> playOn: aScripter [
	aScripter element eventSimulator keyDown: self key.
	aScripter settle
]
