Class {
	#name : #BrStencilDynamicExecutor,
	#superclass : #BrStencilExecutor,
	#instVars : [
		'valuable'
	],
	#category : #'Bloc-Basic-Stencil'
}

{ #category : #running }
BrStencilDynamicExecutor >> execute: aCollectionOfArguments [
	self subclassResponsibility
]
