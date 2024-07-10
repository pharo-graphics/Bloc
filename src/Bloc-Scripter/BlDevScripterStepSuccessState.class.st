Class {
	#name : #BlDevScripterStepSuccessState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-Scripter-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepSuccessState >> color [
	^ (Color r: 0.5845552297165201 g: 0.8709677419354839 b: 0.3919843597262952 alpha: 1.0)
]

{ #category : #accessing }
BlDevScripterStepSuccessState >> name [
	^ 'success'
]

{ #category : #testing }
BlDevScripterStepSuccessState >> wasExecuted [

	^ true
]
