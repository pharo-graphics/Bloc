Class {
	#name : #BrStencilBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'executor'
	],
	#category : #'Bloc-Basic-Stencil'
}

{ #category : #'api - converting' }
BrStencilBuilder >> asElement [
	"Build a corresponding stencil and ask it to create and return a new element"
	<return: #BlElement>
	
	^ self build asElement
]

{ #category : #'api - converting' }
BrStencilBuilder >> asStencilBuilder [
	<return: #BrStencilBuilder>

	^ self
]

{ #category : #'api - converting' }
BrStencilBuilder >> asStencilBuilder: aStencilBuilderClass [
	<return: #BrStencilBuilder>

	^ self
]

{ #category : #building }
BrStencilBuilder >> build [
	<return: #BrStencil>
	| anExecutor |
	
	anExecutor := executor.
	anExecutor resetArguments.
	self paramsOn: anExecutor.
	^ anExecutor execute
]

{ #category : #'api - instantiation' }
BrStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ self subclassResponsibility
]

{ #category : #accessing }
BrStencilBuilder >> executor: aBrStencilExecutor [
	self
		assert: [ aBrStencilExecutor isNotNil ]
		description: [ 'Executor must not be nil' ].
	
	executor := aBrStencilExecutor
]

{ #category : #initialization }
BrStencilBuilder >> initialize [
	super initialize.
	
	executor := BrStencilDefaultExecutor new stencil: self
]

{ #category : #'api - instantiation' }
BrStencilBuilder >> paramsOn: aStencilExecutor [
]
