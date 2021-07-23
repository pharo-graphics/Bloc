Class {
	#name : 'BrStencilDefaultExecutor',
	#superclass : 'BrStencilExecutor',
	#instVars : [
		'stencil'
	],
	#category : 'Bloc-Basic-Stencil'
}

{ #category : 'api - running' }
BrStencilDefaultExecutor >> execute [
	<return: #BlElement>

	^ self stencil buildDefault
]

{ #category : 'api - arguments' }
BrStencilDefaultExecutor >> push: anArgumentObject [
]

{ #category : 'api - arguments' }
BrStencilDefaultExecutor >> resetArguments [
]

{ #category : 'accessing' }
BrStencilDefaultExecutor >> stencil [
	^ stencil
]

{ #category : 'accessing' }
BrStencilDefaultExecutor >> stencil: anObject [
	stencil := anObject
]
