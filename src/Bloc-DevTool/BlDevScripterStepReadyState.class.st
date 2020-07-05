Class {
	#name : #BlDevScripterStepReadyState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-DevTool-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepReadyState >> color [
	^ BrGlamorousColors neutralBackgroundColor
]

{ #category : #accessing }
BlDevScripterStepReadyState >> name [
	^ 'ready'
]
