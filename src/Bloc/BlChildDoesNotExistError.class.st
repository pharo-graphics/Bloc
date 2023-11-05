Class {
	#name : 'BlChildDoesNotExistError',
	#superclass : 'Error',
	#instVars : [
		'parent',
		'child'
	],
	#category : 'Bloc-Basic-Errors'
}

{ #category : 'accessing' }
BlChildDoesNotExistError >> child [
	^ child
]

{ #category : 'accessing' }
BlChildDoesNotExistError >> child: anObject [
	child := anObject
]

{ #category : 'accessing' }
BlChildDoesNotExistError >> description [
	^ 'An element {1} is not a direct child of {2}'
		format: { 
			self child.
			self parent
		}
]

{ #category : 'accessing' }
BlChildDoesNotExistError >> parent [
	^ parent
]

{ #category : 'accessing' }
BlChildDoesNotExistError >> parent: anObject [
	parent := anObject
]
