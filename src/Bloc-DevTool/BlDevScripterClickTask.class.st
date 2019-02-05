Class {
	#name : #BlDevScripterClickTask,
	#superclass : #BlDevScripterInteractionTask,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterClickTask >> label [
	^ 'Click'
]

{ #category : #actions }
BlDevScripterClickTask >> playOn: aScripter [
	BlSpace simulateClickOn: aScripter element
]
