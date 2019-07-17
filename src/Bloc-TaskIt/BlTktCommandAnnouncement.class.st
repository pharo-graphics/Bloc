Class {
	#name : #BlTktCommandAnnouncement,
	#superclass : #Announcement,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'command'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #accessing }
BlTktCommandAnnouncement >> command [
	<return: #BlTktAnnouncingCommand>
	^ command
]

{ #category : #accessing }
BlTktCommandAnnouncement >> command: aBlTktAnnouncingCommand [
	self
		assert: [ aBlTktAnnouncingCommand isNotNil ] 
		description: [ 'Announcement command must be non-nil' ].
	command := aBlTktAnnouncingCommand
]
