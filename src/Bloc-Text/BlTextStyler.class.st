"
I am an Abstract class responsible for applying text attributes on `BlText` based on some logic, for example it can be code syntax highlighting.
The styling is runned by the launcher I provide.
My launcher performs the styling in a background process or through a enqueued task.


The main entrance point used by the launcher is style:
Subclasses of me can create formatted, coloured, and styled copies of Text that is given to them.


"
Class {
	#name : #BlTextStyler,
	#superclass : #Object,
	#instVars : [
		'text',
		'launcher'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #initialization }
BlTextStyler >> defaultStylerLauncher [
	^ BlTextStylerLauncher new
]

{ #category : #initialization }
BlTextStyler >> initialize [
	super initialize.
	launcher := self defaultStylerLauncher
]

{ #category : #accessing }
BlTextStyler >> launcher [
	^ launcher 
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
	^ aStyledText text
]
