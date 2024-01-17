Class {
	#name : 'BlTextAnnouncer',
	#superclass : 'Announcer',
	#instVars : [
		'suspendAll',
		'suspendedAnnouncemets'
	],
	#category : 'Bloc-Text-Text',
	#package : 'Bloc-Text',
	#tag : 'Text'
}

{ #category : 'announce' }
BlTextAnnouncer >> announce: anAnnouncement [
	(self isAnnouncementSuspended: anAnnouncement) ifTrue: [ ^ anAnnouncement asAnnouncement ].
	^ super announce: anAnnouncement
]

{ #category : 'accessing' }
BlTextAnnouncer >> announcer [ 
	^ self
]

{ #category : 'accessing' }
BlTextAnnouncer >> glmSubscriptions [
	^ registry glmSubscriptions
]

{ #category : 'testing' }
BlTextAnnouncer >> isAnnouncementSuspended: anAnnouncement [
	^ self suspendAll or: [ |announcementType|
		announcementType := anAnnouncement isClass 
			ifTrue: [ anAnnouncement ] ifFalse: [ anAnnouncement class ].
		self suspendedAnnouncemets anySatisfy: [ :anAnnouncementType |
			"Suspend the announcement if it has the same class or if it inherits from a suspended announcement class."
			announcementType = anAnnouncementType or: [ announcementType  inheritsFrom: anAnnouncementType ]  ] ]
]

{ #category : 'copying' }
BlTextAnnouncer >> postCopy [
	super postCopy.
	registry := registry copy.
]

{ #category : 'accessing' }
BlTextAnnouncer >> resetAnnouncer [
	registry reset
]

{ #category : 'suspending' }
BlTextAnnouncer >> suspendAll [
	^ suspendAll ifNil: [ suspendAll := false ].
]

{ #category : 'suspending' }
BlTextAnnouncer >> suspendAll: aCollection while: aBlock [
	| previousSuspendedAnnouncemets |
	previousSuspendedAnnouncemets := suspendedAnnouncemets.
	suspendedAnnouncemets := aCollection copy.
	aBlock ensure: [suspendedAnnouncemets := previousSuspendedAnnouncemets] 
]

{ #category : 'suspending' }
BlTextAnnouncer >> suspendAllWhile: aBlock [
	| previousSuspensionState |
	previousSuspensionState := suspendAll.
	suspendAll := true.
	aBlock ensure: [suspendAll := previousSuspensionState]
	
]

{ #category : 'accessing' }
BlTextAnnouncer >> suspendedAnnouncemets [
	^ suspendedAnnouncemets ifNil: [ suspendedAnnouncemets := OrderedCollection new ].
]
