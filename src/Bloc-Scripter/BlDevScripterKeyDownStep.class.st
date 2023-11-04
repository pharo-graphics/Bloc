Class {
	#name : 'BlDevScripterKeyDownStep',
	#superclass : 'BlDevScripterKeyboardStep',
	#category : 'Bloc-Scripter-Scripter-Steps',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Steps'
}

{ #category : 'accessing' }
BlDevScripterKeyDownStep >> defaultLabel [
	^ 'Key down'
]

{ #category : 'actions' }
BlDevScripterKeyDownStep >> playOn: aScripter [
	BlSpace simulateKeyDownOn: aScripter element key: self key.
	aScripter pulse
]
