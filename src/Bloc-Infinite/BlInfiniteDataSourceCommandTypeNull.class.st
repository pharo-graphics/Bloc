"
I am a null command and do nothing
"
Class {
	#name : #BlInfiniteDataSourceCommandTypeNull,
	#superclass : #BlInfiniteDataSourceCommandType,
	#category : 'Bloc-Infinite-DataSource-Support'
}

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> apply: aCommand on: aContext [
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> apply: aCommand onPosition: aPosition [
	^ aPosition
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> continuous: aPosition start: start [
	^ aPosition = (start + 1)
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> dispatch: aCommand toLayout: aLayout [
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> offsetPositions: aCommand on: aDataSourceController [
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> positionMultiplier [
	^ 1
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> updateElementHoldersOn: aContext command: aCommand [
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> updateElementHoldersOn: aContext offset: offsetStart command: aCommand [
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeNull >> updatePosition: aPosition with: aCommand from: myCommand [
	^ aPosition
]
