"
I am a type of data source update command.
I suppose to be stateless and therefore immutable.
For performance and memory reasons I provide a unique instance of me to be shared among my users

"
Class {
	#name : #BlInfiniteDataSourceCommandType,
	#superclass : #Object,
	#pools : [
		'BlInfiniteConstants'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Bloc-Infinite-DataSource'
}

{ #category : #accessing }
BlInfiniteDataSourceCommandType class >> cleanUp [
	super cleanUp.
	
	instance := nil
]

{ #category : #accessing }
BlInfiniteDataSourceCommandType class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> apply: aCommand in: anInfiniteElement [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> apply: aCommand onPosition: aPosition [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> continuous: aPosition start: start [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> dispatch: aCommand toLayout: aLayout [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlInfiniteDataSourceCommandType >> elementHolderAt: aPosition in: anInfiniteElement [
	<return: #BlElement or: nil>

	^ anInfiniteElement findElementHolderForPosition: aPosition checkNew: true
]

{ #category : #testing }
BlInfiniteDataSourceCommandType >> isAdd [
	^ false
]

{ #category : #testing }
BlInfiniteDataSourceCommandType >> isMove [
	^ false
]

{ #category : #testing }
BlInfiniteDataSourceCommandType >> isRemove [
	^ false
]

{ #category : #testing }
BlInfiniteDataSourceCommandType >> isUpdate [
	^ false
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> offsetPositions: aCommand in: anInfiniteElement [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> positionMultiplier [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> updateElementHoldersIn: anInfiniteElement command: aCommand [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> updatePosition: aPosition with: aCommand from: myCommand [
	^ self subclassResponsibility
]
