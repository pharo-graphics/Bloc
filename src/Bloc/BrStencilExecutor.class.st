Class {
	#name : #BrStencilExecutor,
	#superclass : #Object,
	#category : #'Bloc-Basic-Stencil'
}

{ #category : #'api - running' }
BrStencilExecutor >> execute [
	<return: #BlElement>

	self subclassResponsibility
]

{ #category : #'api - arguments' }
BrStencilExecutor >> push: anArgumentObject [
	self subclassResponsibility
]

{ #category : #'api - arguments' }
BrStencilExecutor >> resetArguments [
	self subclassResponsibility
]
