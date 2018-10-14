Class {
	#name : #BlTextStyler,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'backgroundProcess',
		'text',
		'monitor',
		'view',
		'stylingEnabled',
		'eventDispatcher',
		'delay'
	],
	#category : #'Bloc-Text-Text-Styler'
}

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
	eventDispatcher := BlBubblingEventDispatcher on: self.
	delay := 200 milliSeconds
]

{ #category : #private }
BlTextStyler >> monitor [
	monitor isNil
		ifTrue: [monitor := Monitor new].
	^ monitor
]

{ #category : #private }
BlTextStyler >> privateStyle: aText [ 
	self shouldBeImplemented
]

{ #category : #styling }
BlTextStyler >> style: aBrText [
	| styledText |

	self terminateBackgroundStylingProcess.

	stylingEnabled
		ifFalse: [ ^ self ].

	styledText := self privateStyle: aBrText unstyle.
	self fireEvent: (BlTextStyledEvent new text: styledText).
	^ styledText
]

{ #category : #styling }
BlTextStyler >> styleInBackgroundProcess: aBrText [
	self styleInBackgroundProcess: aBrText andAfterDo: [ "nothing" ]
]

{ #category : #styling }
BlTextStyler >> styleInBackgroundProcess: aBrText andAfterDo: aBlock [

	self terminateBackgroundStylingProcess.
	
	stylingEnabled
		ifFalse: [ ^ self ].

	self monitor critical: [
		backgroundProcess := [
			| styledText |
			delay asDelay wait.
			text := aBrText unstyle.
			styledText := self privateStyle: text.
			BlUniverse defer: [ 
				self fireEvent: (BlTextStyledEvent new text: styledText).
				aBlock value ].
		 ] forkAt: Processor userBackgroundPriority ]
]

{ #category : #styling }
BlTextStyler >> styleInBackgroundProcessNow: aBrText [
	
	self terminateBackgroundStylingProcess.
	
	stylingEnabled
		ifFalse: [ ^ self ].

	self monitor critical: [
		backgroundProcess := [
			| styledText |
			text := aBrText unstyle.
			styledText := self privateStyle: text.
			BlUniverse defer: [ self fireEvent: (BlTextStyledEvent new text: styledText) ].
		 ] forkAt: Processor userBackgroundPriority ]
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

{ #category : #private }
BlTextStyler >> terminateBackgroundStylingProcess [
	self monitor critical: [
		backgroundProcess ifNotNil: [
			backgroundProcess terminate.
			backgroundProcess := nil ] ]
]

{ #category : #styling }
BlTextStyler >> unstyledTextFrom: aBrText [ 
	^ aBrText unstyled
]

{ #category : #accessing }
BlTextStyler >> view: aViewOrMorph [ 
	view := aViewOrMorph
]
