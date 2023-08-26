Class {
	#name : #BlDevScripterKeyUpStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyUpStep >> defaultLabel [
	^ 'Key up'
]

{ #category : #actions }
BlDevScripterKeyUpStep >> playOn: aScripter [
	BlOSpace simulateKeyUpOn: aScripter element key: self key.
	aScripter pulse
]
