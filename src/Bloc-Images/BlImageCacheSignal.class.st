Class {
	#name : #BlImageCacheSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'event',
		'value',
		'currentSize'
	],
	#category : #'Bloc-Images-Cache'
}

{ #category : #'instance creation' }
BlImageCacheSignal class >> emitEvent: aSymbol value: anObject [

	^self new 
		event: aSymbol;
		value: anObject;
		emit
]

{ #category : #'instance creation' }
BlImageCacheSignal class >> emitEvent: aSymbol value: anObject currentSize: anInteger [

	^self new 
		event: aSymbol;
		value: anObject;
		currentSize: anInteger;
		emit
]

{ #category : #accessing }
BlImageCacheSignal >> currentSize [
	^ currentSize
]

{ #category : #accessing }
BlImageCacheSignal >> currentSize: anObject [
	currentSize := anObject
]

{ #category : #accessing }
BlImageCacheSignal >> event [
	^ event
]

{ #category : #accessing }
BlImageCacheSignal >> event: anObject [
	event := anObject
]

{ #category : #printing }
BlImageCacheSignal >> printOneLineContentsOn: stream [

	stream << event.
	value ifNotNil: [ 
		stream
			<< ': ';
			<< value asString ].
	stream 
		<< ', size: ';
		print: currentSize.
]

{ #category : #accessing }
BlImageCacheSignal >> value [
	^ value
]

{ #category : #accessing }
BlImageCacheSignal >> value: anObject [
	value := anObject
]
