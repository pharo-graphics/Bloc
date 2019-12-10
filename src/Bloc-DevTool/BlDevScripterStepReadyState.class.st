Class {
	#name : #BlDevScripterStepReadyState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-DevTool-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepReadyState >> color [
	^ Color black alpha: 0.65
]

{ #category : #accessing }
BlDevScripterStepReadyState >> name [
	^ 'ready'
]
