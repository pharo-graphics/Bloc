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
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'launcher'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #'api - text style' }
BlTextStyler >> announceStateChanged [

	self announcerDo: [ :anAnnouncer | 
		anAnnouncer announce: BlStylerStateChanged ]
]

{ #category : #'api - text style' }
BlTextStyler >> announceTextStyled: aBlText [

	self announce: (BlStylerTextStyled styledText: aBlText)
]

{ #category : #initialization }
BlTextStyler >> defaultStylerLauncher [
	^ BlTextStylerLauncher new
]

{ #category : #accessing }
BlTextStyler >> fontName: aFontName [
]

{ #category : #initialization }
BlTextStyler >> initialize [
	super initialize.
	launcher := self defaultStylerLauncher.
	self whenAnnouncement: BlStylerTextStyleRequested send: #whenTextStyleRequested: to: self.
]

{ #category : #'api - text style' }
BlTextStyler >> launchStyle: aBlText in: anElement [

	^ self launcher styleText: aBlText withStyler: self inElement: anElement
]

{ #category : #accessing }
BlTextStyler >> launcher [
	^ launcher 
]

{ #category : #copying }
BlTextStyler >> postCopy [
	self resetAnnouncer
]

{ #category : #private }
BlTextStyler >> privateStyle: aText [ 
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #styling }
BlTextStyler >> style: aBlText [
	"Return the styled text based on the argument. Announced the styling."
	
	| anUnstyledText aStyledText |
	" it is important style a copy because of the BlText announcer. In the copied BlText, the announcer will not be initialize and no announcement will be sent "
	anUnstyledText := aBlText copy unstyle.
	aStyledText := self privateStyle: anUnstyledText.
	self announceTextStyled: aStyledText.
	^ aStyledText
]

{ #category : #'api - text style' }
BlTextStyler >> whenTextStyleRequested: aBlStylerTextStyleRequested [

	" a client request text styling "
	^ self launcher
		  styleText: aBlStylerTextStyleRequested unstyledText
		  withStyler: self
		  inElement: aBlStylerTextStyleRequested referentElement
]
