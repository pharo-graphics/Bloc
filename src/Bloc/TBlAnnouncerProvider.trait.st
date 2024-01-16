"
I provide an announcer with necessary methods 
"
Trait {
	#name : #TBlAnnouncerProvider,
	#instVars : [
		'privateAnnouncer',
		'privateAnnouncerIsPlugged'
	],
	#traits : 'TBlAnnounceable',
	#classTraits : 'TBlAnnounceable classTrait',
	#category : #'Bloc-Basic-Support'
}

{ #category : #'event management' }
TBlAnnouncerProvider >> announce: anAnnouncement [

	self announcerIsPlugged ifFalse: [ ^ self ].
	self announcerDo: [ :ann | ann announce: anAnnouncement ]
]

{ #category : #'private - accessing' }
TBlAnnouncerProvider >> announcerIsPlugged [

	^ privateAnnouncerIsPlugged ifNil: [ privateAnnouncerIsPlugged := true ]
]

{ #category : #'private - accessing' }
TBlAnnouncerProvider >> ensureAnnouncer [

	privateAnnouncer ifNil: [ privateAnnouncer := Announcer new ]
]

{ #category : #'private - accessing' }
TBlAnnouncerProvider >> privateAnnouncer [

	^ privateAnnouncer
]

{ #category : #'private - accessing' }
TBlAnnouncerProvider >> resetAnnouncer [

	privateAnnouncer := nil 
]

{ #category : #'private - accessing' }
TBlAnnouncerProvider >> unplugAnnouncerWhile: aBlock [

	privateAnnouncerIsPlugged := false.
	aBlock ensure: [ privateAnnouncerIsPlugged := true ]
]
