Class {
	#name : #BlDevScripterKeyDownStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyDownStep >> defaultLabel [
	^ 'Key down'
]

{ #category : #actions }
BlDevScripterKeyDownStep >> playOn: aScripter [
	BlSpace simulateKeyDownOn: aScripter element key: self key.
	aScripter pulse
]
