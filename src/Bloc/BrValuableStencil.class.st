"
I am a special type of stencil whose `=#create`= method can be dynamically defined with the help of a valuable object.

To get a Statefull version of the Stencil users can provide a collection of `=#arguments`= that will be passed to the valuable in the same order as in argument collection.

"
Class {
	#name : #BrValuableStencil,
	#superclass : #BrStencil,
	#instVars : [
		'valuable',
		'arguments'
	],
	#category : #'Bloc-Basic-Stencil'
}

{ #category : #'instance creation' }
BrValuableStencil class >> from: aValuable [
	<return: #BrStencil>

	^ self new valuable: aValuable
]

{ #category : #accessing }
BrValuableStencil >> arguments [
	<return: #Collection of: #Object>

	^ arguments
]

{ #category : #accessing }
BrValuableStencil >> arguments: aCollectionOfObjects [
	arguments := aCollectionOfObjects
]

{ #category : #'api - instantiation' }
BrValuableStencil >> create [
	<return: #Object>
	
	^ self valuable glamourValueWithArgs: self arguments
]

{ #category : #accessing }
BrValuableStencil >> valuable [
	^ valuable
]

{ #category : #accessing }
BrValuableStencil >> valuable: anObject [
	valuable := anObject
]
