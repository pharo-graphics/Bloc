"
I provide an announcer with necessary methods 
"
Trait {
	#name : #TBlAnnouncerProvider,
	#instVars : [
		'privateAnnouncer'
	],
	#traits : 'TBlAnnounceable',
	#classTraits : 'TBlAnnounceable classTrait',
	#category : #'Bloc-Basic-Support'
}

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
