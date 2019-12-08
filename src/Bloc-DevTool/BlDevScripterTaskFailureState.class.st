Class {
	#name : #BlDevScripterTaskFailureState,
	#superclass : #BlDevScripterTaskState,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterTaskFailureState >> color [
	^ Color fromHexString: #ffa39e
]

{ #category : #testing }
BlDevScripterTaskFailureState >> wasExecuted [
	<return: #Boolean>
	^ true
]
