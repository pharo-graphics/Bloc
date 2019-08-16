"
I am responsible for applying text attributes on ${class:BlText}$ based on some logic, for example it can be code syntax highlighting.

I am independent from the text editor.
The main entrance point is 
"
Class {
	#name : #BlTextStyler,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'task',
		'text',
		'view',
		'stylingEnabled',
		'eventDispatcher',
		'delay'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BlTextStyler >> delay [
	<return: #Duration>
	^ delay
]

{ #category : #styling }
BlTextStyler >> doStyle: aBrText afterDo: aBlock [
	"A styling activity called from styler tasks"
	| styledText |

	styledText := self privateStyle: aBrText unstyle.
	self fireEvent: (BlTextStyledEvent new text: styledText).
	aBlock value.
]

{ #category : #styling }
BlTextStyler >> doStyleInBackground: aBrText andAfterDo: aBlock [
	"A styling activity called from styler tasks"
	| styledText aTaskAction |

	styledText := self privateStyle: aBrText unstyle.
	
	aTaskAction := [ 
		self fireEvent: (BlTextStyledEvent new text: styledText).
		aBlock value ].
	
	view isNotNil
		ifTrue: [
			(view at: 1)
				ifNotNil: [ :anElement | anElement enqueueTask: (BlTaskAction new action: aTaskAction) ]
				ifNil: aTaskAction ]
		ifFalse: aTaskAction.
]

{ #category : #'event management accessing' }
BlTextStyler >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
BlTextStyler >> initialize [
	super initialize.
	
	stylingEnabled := true.
	eventDispatcher := BlBubblingEventDispatcher on: self..
	task := BlTextStylerTaskItTask new styler: self.
	delay := 200 milliSeconds
]

{ #category : #private }
BlTextStyler >> privateStyle: aText [ 
	self shouldBeImplemented
]

{ #category : #styling }
BlTextStyler >> style: aBrText [
	self style: aBrText afterDo: [ "do nothing" ].
]

{ #category : #styling }
BlTextStyler >> style: aBrText afterDo: aBlock [
	stylingEnabled ifFalse: [ ^ self ].
	task style: aBrText afterDo: aBlock
]

{ #category : #styling }
BlTextStyler >> styledTextFor: aText [ 
	^self privateStyle: aText
]

{ #category : #private }
BlTextStyler >> stylingEnabled [
	^ stylingEnabled
]

{ #category : #private }
BlTextStyler >> stylingEnabled: aBoolean [
	stylingEnabled := aBoolean
]

{ #category : #accessing }
BlTextStyler >> task: aBlTextStylerTask [
	self 
		assert: [ aBlTextStylerTask isNotNil ]
		description: [ 'Text styler task must be non-nil' ].
	task := aBlTextStylerTask
]

{ #category : #styling }
BlTextStyler >> unstyledTextFrom: aBrText [ 
	^ aBrText unstyled
]

{ #category : #accessing }
BlTextStyler >> view: aViewOrMorph [ 
	view := aViewOrMorph
]
