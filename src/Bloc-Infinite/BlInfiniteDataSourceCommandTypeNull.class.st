Class {
	#name : 'BlInfiniteDataSourceCommandTypeNull',
	#superclass : 'BlInfiniteDataSourceCommandType',
	#category : 'Bloc-Infinite-DataSource',
	#package : 'Bloc-Infinite',
	#tag : 'DataSource'
}

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeNull >> apply: aCommand in: anInfiniteElement [
	
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeNull >> apply: aCommand onPosition: aPosition [
	^ aPosition
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeNull >> continuous: aPosition start: start [
	^ aPosition = (start + 1)
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeNull >> dispatch: aCommand toLayout: aLayout [
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeNull >> offsetPositions: aCommand in: anInfiniteElement [

]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeNull >> positionMultiplier [
	^ 1
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeNull >> updateElementHoldersIn: aContext command: aCommand [
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeNull >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeNull >> updatePosition: aPosition with: aCommand from: myCommand [
	^ aPosition
]
