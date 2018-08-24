"
I define an interface between data source manager and infinite element.
Data source manager communicates with infinite element  only using my interface
"
Class {
	#name : #BlInfiniteAbstractDataSourceController,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Infinite-DataSource-Support'
}

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> applyPendingCommandsOnPosition: aPosition [
	"Ask data source manager to apply all pending commands
	on provided position (transform it) and return result.
	aPosition must not be nil"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> computePositionOffset: aPosition [
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> consumeCommandsInOnePass [
	"Ask data source manager to skip pre-processing and
	to apply all commands in one pass."

	^ self subclassResponsibility
]

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> consumePostponedCommands [
	"Ask data source manager to consume all postponed commands"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractDataSourceController >> elementHolderAt: aPosition [
	"Ask infinite element to find and return an element holder
	at aPosition or nil of there is no such.
	aPosition must not be nil"
	<return: #BlInfiniteHolder or: nil>
	
	^ self subclassResponsibility
]

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> hasCommands [
	"Return true if there are both pending and postponed commands,
	otherwise false"
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> hasPendingCommands [
	"Return true if there are pending commands waiting to be processed
	in data source manager, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractDataSourceController >> markElementHoldersUpdated: aStartPosition itemCount: anItemCount payload: aPayloadObject [
	"Ask infinite element to update amount of items defined by itemCount
	starting from aStartPosition with an optional payload object.
	aStartPosition must not be nil.
	anItemCount must not be nil.
	aPayloadObject is optional and may be nil"

	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractDataSourceController >> offsetPositions: aStartPosition forAdd: anItemCount [
	"Ask infinite element to update item positions from startPosition
	in order to add anItemCount amount of new items.
	aStartPosition must not be nil
	anItemCount must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractDataSourceController >> offsetPositions: aStartPosition forRemovingInvisible: anItemCount [
	"Ask infinite element to update item positions after
	removing invisible elements starting from aStartPosition
	an amount defined by anItemCount.
	aStartPosition must not be nil.
	anItemCount must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractDataSourceController >> offsetPositions: aStartPosition forRemovingLaidOutOrNewElement: anItemCount [
	"Ask infinite element to update item positions starting
	at aStartPosition in order to remove by anItemCount defined amount
	of already laid out or new elements.
	aStartPosition must not be nil.
	anItemCount must not be nil"

	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractDataSourceController >> offsetPositionsForMove: aFromPosition to: aToPosition [
	"Ask infinite element to update item positions in order to move items from fromPosition to toPosition
	fromPosition must not be nil
	toPosition must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractDataSourceController >> onDispatchFirstPass: aCommand [
	"Notify an infinite element that aCommand was dispatched
	during first pass, allowing element to perform further
	dispatches, for example to layout in order to synchronise updates.
	aCommand must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractDataSourceController >> onDispatchSecondPass: aCommand [
	"Notify an infinite element that aCommand was dispatched
	during second pass, allowing element to perform further
	dispatches, for example to layout in order to synchronise updates.
	aCommand must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> onItemRangeChanged: aStartPosition itemCount: anItemCount payload: aPayloadObject [
	"Ask data source manager to enqueue a corresponding command that items were changed.
	Return true if commands should be processed, false otherwise.
	startPosition must not be nil.
	itemCount must not be nil.
	anObject is optional and may be nil"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> onItemRangeInserted: aStartPosition itemCount: itemCount [
	"Ask data source manager to enqueue a corresponding command that items were inserted.
	Return true if commands should be processed, false otherwise.
	startPosition must not be nil.
	itemCount must not be nil."
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> preProcessCommands [
	"Ask data source manager to pre-process all pending commands"

	^ self subclassResponsibility
]

{ #category : #'element -> manager' }
BlInfiniteAbstractDataSourceController >> resetCommands [
	"Ask data source manager to reset itself to initial state"
	
	^ self subclassResponsibility
]
