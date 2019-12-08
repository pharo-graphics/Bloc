Class {
	#name : #BlDevScripterTaskSuccessState,
	#superclass : #BlDevScripterTaskState,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterTaskSuccessState >> color [
	^ Color fromHexString: #b7eb8f
]

{ #category : #testing }
BlDevScripterTaskSuccessState >> wasExecuted [
	<return: #Boolean>
	^ true
]
