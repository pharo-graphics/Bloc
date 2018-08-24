Class {
	#name : #BlEventHandlerAnnouncementDeliveryCondition,
	#superclass : #Object,
	#instVars : [
		'eventHandler'
	],
	#category : 'Bloc-EventHandling'
}

{ #category : #accessing }
BlEventHandlerAnnouncementDeliveryCondition >> eventHandler [
	^ eventHandler
]

{ #category : #accessing }
BlEventHandlerAnnouncementDeliveryCondition >> eventHandler: anObject [
	eventHandler := anObject
]

{ #category : #testing }
BlEventHandlerAnnouncementDeliveryCondition >> handlesAnnouncement: anEvent [
	^ self eventHandler wantsEvent: anEvent
]
