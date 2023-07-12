Class {
	#name : #BlDevScripterKeyClickStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyClickStep >> defaultLabel [
	^ 'Key press'
]

{ #category : #actions }
BlDevScripterKeyClickStep >> playOn: aScripter [
	BlOSpace simulateKeyDownOn: aScripter element key: self key.
	BlOSpace simulateKeyUpOn: aScripter element key: self key.
	aScripter pulse
]
