Class {
	#name : #BlTaskNotifications,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'Bloc-TaskIt-Tasks'
}

{ #category : #adding }
BlTaskNotifications >> addNotification: aNotificationClass handler: aHandler [
	collection add: (BlTaskNotificationHandler new
		notification: aNotificationClass;
		handler: aHandler)
]

{ #category : #running }
BlTaskNotifications >> execute: aValuable [
	| anHandledValuable |
	anHandledValuable := collection
		inject: aValuable  
		into: [ :eachHandledValuable :eachHandler |
			[ eachHandledValuable on: eachHandler notification do: eachHandler handler ] ].
	^ anHandledValuable value
]

{ #category : #initialization }
BlTaskNotifications >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : #running }
BlTaskNotifications >> maybeNotifyDuring: aValuable [
	^ BlSignalProgress 
		value: collection notEmpty
		during: [ self execute: aValuable ]
]
