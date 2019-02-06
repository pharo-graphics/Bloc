Class {
	#name : #BlDevScripterEventTarget,
	#superclass : #Object,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #searching }
BlDevScripterEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	^ self subclassResponsibility
]
