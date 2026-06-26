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
	(BlEventSimulator forElement: aScripter element) keyPress: self key.
	aScripter pulse
]
