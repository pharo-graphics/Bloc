Class {
	#name : #BlTktAnnouncingCommand,
	#superclass : #BlTktDecoratedCommand,
	#instVars : [
		'announcer'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #announcements }
BlTktAnnouncingCommand >> announceAboutToExecute [
	self announcer announce: (BlTktCommandAboutToExecuteAnnouncement new command: self)
]

{ #category : #announcements }
BlTktAnnouncingCommand >> announceAboutToFinishWithResult: anObject [
	self announcer announce: (BlTktCommandAboutToFinishAnnouncement new command: self; result: anObject)
]

{ #category : #accessing }
BlTktAnnouncingCommand >> announcer [
	<return: #Announce>
	^ announcer
]

{ #category : #converting }
BlTktAnnouncingCommand >> asAnnouncingCommand [
	<return: #BlTktAnnouncingCommand>
	^ self
]

{ #category : #evaluating }
BlTktAnnouncingCommand >> execute [
	"execute command and return a result"

	<return: #Object>
	| aResult |
	self announceAboutToExecute.
	aResult := self command execute.
	self announceAboutToFinishWithResult: aResult.
	^ aResult
]

{ #category : #initialization }
BlTktAnnouncingCommand >> initialize [
	super initialize.
	announcer := Announcer new.
]

{ #category : #accessing }
BlTktAnnouncingCommand >> name [
	<return: #String>
	^ 'Announcing ', self command name
]
