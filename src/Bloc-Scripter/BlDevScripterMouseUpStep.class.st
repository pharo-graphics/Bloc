Class {
	#name : #BlDevScripterMouseUpStep,
	#superclass : #BlDevScripterMouseStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseUpStep >> defaultLabel [
	^ 'Mouse up'
]

{ #category : #actions }
BlDevScripterMouseUpStep >> playOn: aScripter [
	aScripter element eventSimulator mouseUpAt: (self getMousePositionIn: aScripter).
	aScripter settle
]
