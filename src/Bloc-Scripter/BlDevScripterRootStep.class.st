Class {
	#name : 'BlDevScripterRootStep',
	#superclass : 'BlDevScripterMultipleActionStep',
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : 'accessing' }
BlDevScripterRootStep >> defaultLabel [
	^ 'Root'
]

{ #category : 'testing' }
BlDevScripterRootStep >> isRootStep [
	^ true
]

{ #category : 'execution' }
BlDevScripterRootStep >> startWithExecutor: anExecutor [
	anExecutor executeRootStep: self
]
