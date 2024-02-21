"
I'm an utility Trait for objects that own an Announcer.


"
Trait {
	#name : #TBlAnnounceable,
	#category : #'Bloc-Basic-Support'
}

{ #category : #'event management' }
TBlAnnounceable >> announce: anAnnouncement [

	self announcerDo: [ :ann | ann announce: anAnnouncement ]
]

{ #category : #'event management' }
TBlAnnounceable >> announcerDo: aBlockClosure [

	"Evaluate a given block closure with an announcer as an argument if it is initialized"
	self privateAnnouncer ifNil: [ ^self ].
	aBlockClosure value: self privateAnnouncer
]

{ #category : #'private - accessing' }
TBlAnnounceable >> ensureAnnouncer [

	self explicitRequirement 
]

{ #category : #'private - accessing' }
TBlAnnounceable >> privateAnnouncer [

	^ self explicitRequirement
]

{ #category : #'event management' }
TBlAnnounceable >> unsubscribe: anObject [

	"Unsubscribe all subscriptions of anObject from the receiver"

	self announcerDo: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'event management' }
TBlAnnounceable >> whenAnnouncement: anAnnouncementClass do: aValuable [

	self ensureAnnouncer.
	self privateAnnouncer when: anAnnouncementClass do: aValuable
]

{ #category : #'event management' }
TBlAnnounceable >> whenAnnouncement: anAnnouncementClass send: aSelector to: anObject [

	self ensureAnnouncer.
	self privateAnnouncer weak when: anAnnouncementClass send: aSelector to: anObject
]
