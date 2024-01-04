Class {
	#name : #BlDevScripterMouseDownStep,
	#superclass : #BlDevScripterMouseStep,
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseDownStep >> defaultLabel [
	^ 'Mouse down'
]

{ #category : #actions }
BlDevScripterMouseDownStep >> playOn: aScripter [
	BlSpace simulateMouseDownOn: aScripter element at: (self getMousePositionIn: aScripter).
	aScripter pulse
]
