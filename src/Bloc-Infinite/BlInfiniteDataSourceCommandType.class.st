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
	#category : 'Bloc-Infinite-DataSource-Support'
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
BlInfiniteDataSourceCommandType >> apply: aCommand on: aContext [
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
BlInfiniteDataSourceCommandType >> offsetPositions: aCommand on: aDataSourceController [
	self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> positionMultiplier [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> updateElementHoldersOn: aContext command: aCommand [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> updateElementHoldersOn: aContext offset: offsetStart command: aCommand [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandType >> updatePosition: aPosition with: aCommand from: myCommand [
	^ self subclassResponsibility
]
