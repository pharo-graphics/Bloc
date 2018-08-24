Class {
	#name : #BlHandlerAnnouncementSubscription,
	#superclass : #Object,
	#instVars : [
		'subscriber'
	],
	#category : 'Bloc-EventHandling'
}

{ #category : #comparing }
BlHandlerAnnouncementSubscription >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	^ anotherObject subscriber = self subscriber
]

{ #category : #announcing }
BlHandlerAnnouncementSubscription >> deliver: anAnnouncement [

	(self handlesAnnouncement: anAnnouncement)
		ifTrue: [ self subscriber handleEvent: anAnnouncement ]
]

{ #category : #testing }
BlHandlerAnnouncementSubscription >> handlesAnnouncement: anAnnouncement [
	<return: #Boolean>

	^ self subscriber wantsEvent: anAnnouncement
]

{ #category : #comparing }
BlHandlerAnnouncementSubscription >> hash [
	^ self class hash bitXor: self subscriber hash
]

{ #category : #accessing }
BlHandlerAnnouncementSubscription >> subscriber [
	<return: #TBlEventHandler>

	^ subscriber
]

{ #category : #accessing }
BlHandlerAnnouncementSubscription >> subscriber: aTBlEventHandler [
	subscriber := aTBlEventHandler
]
