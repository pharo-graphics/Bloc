"
I'm an utility Trait for objects that own an Announcer.


"
Trait {
	#name : #TBlAnnounceable,
	#instVars : [
		'announcer'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #'event management' }
TBlAnnounceable >> announce: anAnnouncement [

	self announcerDo: [ :ann | ann announce: anAnnouncement ]
]

{ #category : #'event management' }
TBlAnnounceable >> announcerDo: aBlockClosure [

	"Evaluate a given block closure with an announcer as an argument if it is initialized"

	announcer ifNotNil: aBlockClosure
]

{ #category : #'private - accessing' }
TBlAnnounceable >> ensureAnnouncer [
	announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'private - accessing' }
TBlAnnounceable >> privateAnnouncer [
	^ announcer
]

{ #category : #initialization }
TBlAnnounceable >> resetAnnouncer [

	announcer := nil
]

{ #category : #'event management' }
TBlAnnounceable >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	self announcerDo: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'event management' }
TBlAnnounceable >> when: anAnnouncementClass do: aValuable [
	self ensureAnnouncer.
	announcer when: anAnnouncementClass do: aValuable
]

{ #category : #'event management' }
TBlAnnounceable >> when: anAnnouncementClass send: aSelector to: anObject [
	self ensureAnnouncer.
	announcer weak when: anAnnouncementClass send: aSelector to: anObject
]
