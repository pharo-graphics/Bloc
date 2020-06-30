Class {
	#name : #BlDevScripterKeyUpStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyUpStep >> defaultLabel [
	^ 'Key up'
]

{ #category : #actions }
BlDevScripterKeyUpStep >> playOn: aScripter [
	BlSpace simulateKeyUpOn: aScripter element key: self key.
	aScripter pulse
]
