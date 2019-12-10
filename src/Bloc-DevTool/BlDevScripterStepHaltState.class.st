Class {
	#name : #BlDevScripterStepHaltState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-DevTool-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepHaltState >> color [
	<return: #Color>
	^ Color yellow
]

{ #category : #testing }
BlDevScripterStepHaltState >> isHalt [
	^ true
]

{ #category : #accessing }
BlDevScripterStepHaltState >> name [
	<return: #String>
	^ 'halt'
]
