Trait {
	#name : #TBlAnnouncerProvider,
	#instVars : [
		'announcer'
	],
	#traits : 'TBlAnnounceable',
	#classTraits : 'TBlAnnounceable classTrait',
	#category : #'Bloc-Basic-Support'
}

{ #category : #'private - accessing' }
TBlAnnouncerProvider >> ensureAnnouncer [

	announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'private - accessing' }
TBlAnnouncerProvider >> privateAnnouncer [

	^ announcer
]

{ #category : #'private - accessing' }
TBlAnnouncerProvider >> resetAnnouncer [

	announcer := nil 
]
