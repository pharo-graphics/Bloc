Class {
	#name : #BlAnimationAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'animation',
		'timestamp',
		'progress'
	],
	#category : #'Bloc-Animation-Events'
}

{ #category : #accessing }
BlAnimationAnnouncement >> animation [

	^ animation
]

{ #category : #accessing }
BlAnimationAnnouncement >> animation: anAnimation [

	animation := anAnimation
]

{ #category : #printing }
BlAnimationAnnouncement >> printOn: aStream [
	"Generate a string representation of the receiver based on its instance variables."

	super printOn: aStream.
	aStream
		nextPutAll: ' animation: ';
		print: animation.
	aStream
		nextPutAll: ' timestamp: ';
		print: timestamp.
	aStream
		nextPutAll: ' progress: ';
		print: progress
]

{ #category : #accessing }
BlAnimationAnnouncement >> progress [

	^ progress
]

{ #category : #accessing }
BlAnimationAnnouncement >> progress: anObject [

	progress := anObject
]

{ #category : #accessing }
BlAnimationAnnouncement >> timestamp [

	^ timestamp
]

{ #category : #accessing }
BlAnimationAnnouncement >> timestamp: anObject [

	timestamp := anObject
]
