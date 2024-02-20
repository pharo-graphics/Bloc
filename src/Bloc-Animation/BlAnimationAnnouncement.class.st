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

{ #category : #'instance creation' }
BlAnimationAnnouncement class >> on: aBlAnimation [

	^ self new
		animation: aBlAnimation;
		yourself
]

{ #category : #accessing }
BlAnimationAnnouncement >> animation [

	^ animation
]

{ #category : #accessing }
BlAnimationAnnouncement >> animation: anObject [

	animation := anObject
]

{ #category : #accessing }
BlAnimationAnnouncement >> progress [

	^ progress
]

{ #category : #accessing }
BlAnimationAnnouncement >> timestamp [

	^ timestamp
]
