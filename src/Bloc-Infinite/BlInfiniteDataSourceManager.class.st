"
I manage data source update commands.

I control their order and optimize commands queue.
For example if there are two sequential commands: add and remove at the same position, I annihilate them and do nothing.

My onItemRange* methods are triggered directly or indirectly by data source when it is changed.

Public API and Key Messages

- onItemRangeChanged: itemCount: payload: - is sent by data source when content or value of items was changed
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	commandsReorderer:		<Object>
	controller:		<Object>
	pendingCommands:		<Object>
	postponedCommands:		<Object>


    Implementation Points

"
Class {
	#name : #BlInfiniteDataSourceManager,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'pendingCommands',
		'postponedCommands'
	],
	#category : #'Bloc-Infinite-DataSource'
}

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> applyPendingCommandsOnPosition: aPosition [
	"
	When the position of a an ElementHolder is required.
	Virually perform every pending command to determine how provided
	position will change.	Return new position if all commands would be actually performed"

	| position |
	position := aPosition.
	pendingCommands do: [ :command |
		position := command applyOnPosition: position ].

	^ position
]

{ #category : #helper }
BlInfiniteDataSourceManager >> computePositionOffset: aPosition [
	" Sent when scrolling the infinite "

	| position |
	position := aPosition.

	1 to: postponedCommands size - 1 do: [ :index |
		| command |
		command := postponedCommands at: index.
		command positionStart <= position ifTrue: [
			command isRemove
				ifTrue: [
					position < (command positionStart + command itemCount) ifTrue: [ ^ 0 ].
					position := position - command itemCount ]
				ifFalse: [ command isAdd ifTrue: [ position := position + command itemCount ] ] ] ].
	^ position
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> consumeCommandsIn: anInfiniteElement [
	"Skip pre-processing and perform all pending commands in one pass."

	"we still consume postponed updates (if there is) in case there was a pre-process call
	w/o a matching consumePostponedUpdates."

	[ postponedCommands isEmpty ] whileFalse: [
		| cmd |
		cmd := postponedCommands removeFirst.
		self dispatchCommand: cmd to: anInfiniteElement.
		self recycleCommand: cmd ].

	[ pendingCommands isEmpty ] whileFalse: [
		| cmd |
		cmd := pendingCommands removeFirst.
		self dispatchCommand: cmd to: anInfiniteElement.
		self onCommandProcessed: cmd in: anInfiniteElement.
		self recycleCommand: cmd ]
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> dispatchCommand: aCommand to: anInfiniteElement [
	"Dispatch data source update command to all interested objects,
	in this case to infinite element's layout.
	aCommand must not be nil"
	
	aCommand dispatchToLayout: anInfiniteElement layout
]

{ #category : #testing }
BlInfiniteDataSourceManager >> hasCommands [
	"Return true if there are both pending and postponed commands,
	otherwise false"

	^ self hasPendingCommands and: [ self hasPostponedCommands ]
]

{ #category : #testing }
BlInfiniteDataSourceManager >> hasPendingCommands [
	"Return true if there are pending commands,
	false otherwise"
	<return: #Boolean>

	^ pendingCommands isNotEmpty
]

{ #category : #testing }
BlInfiniteDataSourceManager >> hasPostponedCommands [
	"Return true if there are postponed commands,
	false otherwise"

	^ postponedCommands isNotEmpty
]

{ #category : #initialization }
BlInfiniteDataSourceManager >> initialize [
	super initialize.
	
	postponedCommands := OrderedCollection new.
	pendingCommands := OrderedCollection new
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> onCommandProcessed: aCommand in: anInfiniteElement [

	aCommand offsetPositionsIn: anInfiniteElement.
]

{ #category : #'data source updates' }
BlInfiniteDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [
	"Enqueues a new update pending command.
	I am a part of public API and should be triggered by data source (directly or indirectly)
	when items are changed/updated (item's value, content, or value was replaced in-place).
	Return true if pending commands need to be processed, otherwise false."

	"If no items where updated we do nothing"

	<return: #Boolean>
	anItemCount < 1 ifTrue: [ ^ false ].

	"Register update command"
	pendingCommands add: (BlInfiniteDataSourceUpdateCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 yourself).

	^ pendingCommands notEmpty
]

{ #category : #'data source updates' }
BlInfiniteDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register add command"
	pendingCommands add: (BlInfiniteDataSourceAddCommand new
			positionStart: aPositionStart;
			itemCount: anItemCount).

	^ pendingCommands notEmpty
]

{ #category : #'data source updates' }
BlInfiniteDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register remove command"
	pendingCommands add: (BlInfiniteDataSourceRemoveCommand new
		positionStart: aPositionStart;
		itemCount: anItemCount;
		yourself).
		
	^ pendingCommands notEmpty
]

{ #category : #accessing }
BlInfiniteDataSourceManager >> pendingCommands [

	^ pendingCommands 
]

{ #category : #'commands recycling' }
BlInfiniteDataSourceManager >> recycleCommand: aCommand [
	"Recycle aCommand if recycling enabled"

]

{ #category : #invalidate }
BlInfiniteDataSourceManager >> resetCommands [
	
	pendingCommands removeAll.
	postponedCommands removeAll.
]
