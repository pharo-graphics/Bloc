Class {
	#name : #BlDevScripterKeyClickStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyClickStep >> defaultLabel [
	^ 'Key press'
]

{ #category : #actions }
BlDevScripterKeyClickStep >> playOn: aScripter [
	BlSpace simulateKeyDownOn: aScripter element key: self key.
	BlSpace simulateKeyUpOn: aScripter element key: self key.
	aScripter pulse
]
