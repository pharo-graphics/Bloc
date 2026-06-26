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
	(BlEventSimulator forTarget: aScripter element) simulateMouseUpAt: (self getMousePositionIn: aScripter).
	aScripter pulse
]
