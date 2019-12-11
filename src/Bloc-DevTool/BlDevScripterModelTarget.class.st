Class {
	#name : #BlDevScripterModelTarget,
	#superclass : #BlDevScripterTarget,
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterModelTarget >> findTargetIn: anElement [
	<return: #BlElement>
	^ anElement devScripterData model
]

{ #category : #accessing }
BlDevScripterModelTarget >> identifier [
	^ 'model'
]

{ #category : #printing }
BlDevScripterModelTarget >> printOn: aStream [
	aStream nextPutAll: 'Scripter Model'.
]
