Class {
	#name : #BlDevScripterMouseDownStep,
	#superclass : #BlDevScripterMouseStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseDownStep >> defaultLabel [
	^ 'Mouse down'
]

{ #category : #actions }
BlDevScripterMouseDownStep >> playOn: aScripter [
	(BlEventSimulator forElement: aScripter element) simulateMouseDownAt: (self getMousePositionIn: aScripter).
	aScripter pulse
]
