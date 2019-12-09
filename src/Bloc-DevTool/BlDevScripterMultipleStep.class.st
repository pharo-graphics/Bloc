Class {
	#name : #BlDevScripterMultipleStep,
	#superclass : #BlDevScripterCompositeStep,
	#traits : 'TBlDevScripterStep - {#addStep:}',
	#classTraits : 'TBlDevScripterStep classTrait',
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #tasks }
BlDevScripterMultipleStep >> check [
	^ self addStep: (BlDevScripterMultipleCheckStep new)
]

{ #category : #tasks }
BlDevScripterMultipleStep >> click [
	^ self addStep: (BlDevScripterClickStep new)
]

{ #category : #tasks }
BlDevScripterMultipleStep >> substep [
	^ self addStep: (BlDevScripterMultipleStep new)
]

{ #category : #tasks }
BlDevScripterMultipleStep >> type [
	^ self addStep: BlDevScriptTypeTextStep new
]
