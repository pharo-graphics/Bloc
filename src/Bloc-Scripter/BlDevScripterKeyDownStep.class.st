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
	(BlEventSimulator forElement: aScripter element) simulateKeyDown: self key.
	aScripter pulse
]
