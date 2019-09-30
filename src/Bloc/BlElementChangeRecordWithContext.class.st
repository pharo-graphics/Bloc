Class {
	#name : #BlElementChangeRecordWithContext,
	#superclass : #BlElementChangeRecord,
	#instVars : [
		'context',
		'timestamp'
	],
	#category : #'Bloc-Basic-Changes'
}

{ #category : #accessing }
BlElementChangeRecordWithContext >> context [
	^ context
]

{ #category : #accessing }
BlElementChangeRecordWithContext >> context: anObject [
	context := anObject
]

{ #category : #printing }
BlElementChangeRecordWithContext >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	
	aStream
		nextPutAll: ' | (';
		nextPutAll: self context asString;
		nextPutAll: ')';
		nextPutAll: ' | (';
		nextPutAll: timestamp asString;
		nextPutAll: ')'
]

{ #category : #initialization }
BlElementChangeRecordWithContext >> initialize [
	super initialize.
	
	timestamp := DateAndTime now
]

{ #category : #printing }
BlElementChangeRecordWithContext >> printOn: aStream [
	super printOn: aStream.
	
	aStream
		nextPutAll: ' | (';
		nextPutAll: self context asString;
		nextPutAll: ')';
		nextPutAll: ' | (';
		nextPutAll: timestamp asString;
		nextPutAll: ')'
]
