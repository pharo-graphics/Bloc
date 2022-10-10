"
I am an Abstract class responsible for applying text attributes on `BlText` based on some logic, for example it can be code syntax highlighting. Subclasses of me can create formatted, coloured, and styled copies of Text that is given to them.

The styling is runned by the launcher I provide. My launcher performs the styling in a background process or through a enqueued task. Such a BlTask is enqueued if the element that holds the text is **not** attached to an opened scene.

A user launch styling with #launchStyle:in: with the text and an element as argument. Typically, the element is the text holder but it can be any element that is able to enqueue a BlTask with #enqueueTask:

###Announcements:

Clients may subscribe to `BlStylerTextStyled` and `BlStylerStateChanged` with #when:do or #when:send:to:.

- `BlStylerTextStyled` is announced when a styling is finished. The styled text can be retrieved as a result of sending #textStyled to the instance of `BlStylerTextStyled`.
- `BlStylerStateChanged` is announced whenever the styler state is changed (if this change has an impact on the styling logic).





"
Class {
	#name : #BlTextStyler,
	#superclass : #Object,
	#instVars : [
		'text',
		'launcher',
		'announcer'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BlTextStyler >> announceStateChanged [

	self announcerDo: [ :anAnnouncer | 
		anAnnouncer announce: BlStylerStateChanged ]
]

{ #category : #accessing }
BlTextStyler >> announceTextStyled: aBlText [

	self announcerDo: [ :anAnnouncer | 
		anAnnouncer announce: (BlStylerTextStyled textStyled: aBlText)]
]

{ #category : #notifying }
BlTextStyler >> announcerDo: aBlockClosure [

	"Evaluate a given block closure with an announcer as an argument if it is initialized"

	announcer ifNotNil: aBlockClosure
]

{ #category : #initialization }
BlTextStyler >> defaultStylerLauncher [
	^ BlTextStylerLauncher new
]

{ #category : #notifying }
BlTextStyler >> ensureAnnouncer [
	announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #initialization }
BlTextStyler >> initialize [
	super initialize.
	launcher := self defaultStylerLauncher
]

{ #category : #'api - styling' }
BlTextStyler >> launchStyle: aBlText in: anElement [

	launcher styleText: aBlText withStyler: self inElement: anElement
]

{ #category : #accessing }
BlTextStyler >> launcher [
	^ launcher 
]

{ #category : #copying }
BlTextStyler >> postCopy [
	announcer := nil
]

{ #category : #private }
BlTextStyler >> privateStyle: aText [ 
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'api - styling' }
BlTextStyler >> style: aBlText [

	<return: #BlText>
	| anUnstyledText aStyledText |
	anUnstyledText := aBlText unstyle.
	aStyledText := self privateStyle: anUnstyledText characters.

	self  announceTextStyled: aStyledText text.
	^ aStyledText text
]

{ #category : #'event management' }
BlTextStyler >> when: anAnnouncementClass do: aValuable [
	self ensureAnnouncer.
	announcer when: anAnnouncementClass do: aValuable
]

{ #category : #'event management' }
BlTextStyler >> when: anAnnouncementClass send: aSelector to: anObject [
	self ensureAnnouncer.
	announcer weak when: anAnnouncementClass send: aSelector to: anObject
]
