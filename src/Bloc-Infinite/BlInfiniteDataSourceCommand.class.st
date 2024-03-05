"
I represent a data source update command.

There are 4 times of commands: add, move, remove and update.

Add command describes insertion of one or multiple items in data source.
Move command describes a position change of existing item in data source.
Remove command describes deletion of one or multiple items from data source.
Update command describes content or value change of one or multiple items in data source.

"
Class {
	#name : #BlInfiniteDataSourceCommand,
	#superclass : #BlInfiniteCommand,
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'positionStart',
		'itemCount'
	],
	#category : #'Bloc-Infinite-DataSource'
}

{ #category : #commands }
BlInfiniteDataSourceCommand >> applyOnPosition: aPosition [
	"When the position of an ElementHolder is required.
	Determine how provided position will change. Return the position after command is processed"

	^ self subclassResponsibility 
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> continuous: aPosition start: start [

	^ self subclassResponsibility 
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> dispatchToLayout: aLayout [

	self subclassResponsibility 
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> elementHolderAt: aPosition in: anInfiniteElement [
	<return: #BlElement or: nil>

	^ anInfiniteElement findElementHolderForPosition: aPosition checkNew: true
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isAdd [ 

	^ false
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isRemove [

	^ false
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isUpdate [

	^ false
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> itemCount [

	^ itemCount
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> itemCount: anObject [

	itemCount := anObject
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> offsetPositionsIn: anInfiniteElement [

	self subclassResponsibility 
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> positionMultiplier [

	^ 	self subclassResponsibility 
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> positionStart [

	^ positionStart
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> positionStart: anObject [

	positionStart := anObject
]

{ #category : #enum }
BlInfiniteDataSourceCommand >> typeInvisible [

	^ 0
]

{ #category : #enum }
BlInfiniteDataSourceCommand >> typeNewOrLaidOut [

	^ 1
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> updateElementHoldersIn: anInfiniteElement [

	^ self subclassResponsibility 
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> updateElementHoldersIn: anInfiniteElement offset: offsetStart [

	self subclassResponsibility 
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> updatePosition: aPosition with: aCommand [

	^ self subclassResponsibility 
]
