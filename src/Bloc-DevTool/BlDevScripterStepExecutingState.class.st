Class {
	#name : #BlDevScripterStepExecutingState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-DevTool-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepExecutingState >> color [
	^ Color fromHexString: #'45abfe'
]

{ #category : #accessing }
BlDevScripterStepExecutingState >> name [
	^ 'executing'
]
