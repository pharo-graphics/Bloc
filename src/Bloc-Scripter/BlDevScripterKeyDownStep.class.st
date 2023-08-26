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
	BlOSpace simulateKeyDownOn: aScripter element key: self key.
	aScripter pulse
]
