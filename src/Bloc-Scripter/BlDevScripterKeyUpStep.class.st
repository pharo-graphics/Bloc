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
	(BlEventSimulator forTarget: aScripter element) simulateKeyUp: self key.
	aScripter pulse
]
