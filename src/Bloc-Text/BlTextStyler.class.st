"
I am responsible for applying text attributes on {{gtClass:BlText}} based on some logic, for example it can be code syntax highlighting.

I am independent from the text editor.
The main entrance point is 

"
Class {
	#name : #BlTextStyler,
	#superclass : #Object,
	#instVars : [
		'text'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #'hooks - text modifications' }
BlTextStyler >> onTextStyled: aTextStyledEvent editor: aTextEditor [

	(aTextStyledEvent text isNextGenerationOf: aTextEditor text)
		ifTrue: [ 
			aTextEditor text rope: aTextStyledEvent text text rope.
			aTextStyledEvent afterAction value: aTextEditor text.
			aTextEditor notifyTextStyled.
			aTextEditor processCursorAttributes.
			aTextEditor updater
				all;
				update ]
		ifFalse: [ aTextEditor styleTextAndAfterDo: aTextStyledEvent afterAction ]
]

{ #category : #private }
BlTextStyler >> privateStyle: aText [ 
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'api - styling' }
BlTextStyler >> style: aBlText [
	<return: #BlText>

	^ BlTextStylerTelemetry
		rootTimeSync: [ Processor activeProcess name, '  ', self class name, ': ', (aBlText first: (20 min: aBlText size)) asString ]
		during: [
			| anUnstyledText aStyledText |
			anUnstyledText := aBlText unstyle.
			aStyledText := self privateStyle: anUnstyledText characters.
			aStyledText text ]
]

{ #category : #accessing }
BlTextStyler >> stylers [
	"In case of a composite styler, return children stylers"
	<return: #Collection of: #BlTextStyler>

	^ #()
]
