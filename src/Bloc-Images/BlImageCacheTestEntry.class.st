"
BlLocalImageCacheTestEntry acts as a proxy for ${class:name=BlAsyncImageElement}$ during testing.

"
Class {
	#name : #BlImageCacheTestEntry,
	#superclass : #Object,
	#instVars : [
		'entry'
	],
	#category : #'Bloc-Images-Tests'
}

{ #category : #accessing }
BlImageCacheTestEntry >> entry [
	^ entry
]

{ #category : #accessing }
BlImageCacheTestEntry >> entry: anObject [
	entry := anObject
]
