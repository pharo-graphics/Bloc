"
I am sent by BlText when some pieces of text defined by index intervals are deleted.

"
Class {
	#name : 'BlTextsDeleted',
	#superclass : 'Announcement',
	#instVars : [
		'texts',
		'finalIntervals',
		'requestedIntervals'
	],
	#package : 'Bloc',
	#tag : 'Text-Text-Events',
	#package : 'Bloc-Text',
	#tag : 'Text-Events'
}

{ #category : 'instance creation' }
BlTextsDeleted class >> intervals: aCollectionOfIntervals texts: aCollectionOfTexts [
	^ self new
		intervals: aCollectionOfIntervals;
		texts: aCollectionOfTexts
]

{ #category : 'accessing' }
BlTextsDeleted >> finalIntervals [
	^ finalIntervals
]

{ #category : 'accessing' }
BlTextsDeleted >> finalIntervals: anObject [
	finalIntervals := anObject
]

{ #category : 'accessing' }
BlTextsDeleted >> requestedIntervals [
	^ requestedIntervals
]

{ #category : 'accessing' }
BlTextsDeleted >> requestedIntervals: anObject [
	requestedIntervals := anObject
]

{ #category : 'accessing' }
BlTextsDeleted >> texts [
	^ texts
]

{ #category : 'accessing' }
BlTextsDeleted >> texts: anObject [
	texts := anObject
]
