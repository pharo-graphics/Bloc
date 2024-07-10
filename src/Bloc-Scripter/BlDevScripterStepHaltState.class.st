Class {
	#name : #BlDevScripterStepHaltState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-Scripter-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepHaltState >> color [
	^ (Color r: 1.0 g: 0.8396871945259042 b: 0.3998044965786901 alpha: 1.0)
]

{ #category : #testing }
BlDevScripterStepHaltState >> isHalt [
	^ true
]

{ #category : #accessing }
BlDevScripterStepHaltState >> name [
	"Return the string representing the name of the receiver."

	^ 'halt'
]
