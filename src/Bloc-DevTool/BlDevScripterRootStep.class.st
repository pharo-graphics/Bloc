Class {
	#name : #BlDevScripterRootStep,
	#superclass : #BlDevScripterMultipleActionStep,
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterRootStep >> defaultLabel [
	^ 'Root'
]

{ #category : #execution }
BlDevScripterRootStep >> startWithExecutor: anExecutor [
	anExecutor executeRootStep: self
]
