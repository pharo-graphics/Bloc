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
	aScripter element eventSimulator mouseDownAt: (self getMousePositionIn: aScripter).
	aScripter settle
]
