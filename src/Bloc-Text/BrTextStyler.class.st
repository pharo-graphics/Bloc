Class {
	#name : #BrTextStyler,
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
	#category : 'Bloc-Text-Text-Styler'
}

{ #category : #'event management accessing' }
BrTextStyler >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
BrTextStyler >> initialize [
	super initialize.
	
	stylingEnabled := true.
	eventDispatcher := BlBubblingEventDispatcher on: self.
	delay := 200 milliSeconds
]

{ #category : #private }
BrTextStyler >> monitor [
	monitor isNil
		ifTrue: [monitor := Monitor new].
	^ monitor
]

{ #category : #private }
BrTextStyler >> privateStyle: aText [ 
	self shouldBeImplemented
]

{ #category : #styling }
BrTextStyler >> style: aBrText [
	| styledText |

	self terminateBackgroundStylingProcess.

	stylingEnabled
		ifFalse: [ ^ self ].

	styledText := self privateStyle: aBrText unstyle.
	self fireEvent: (BrTextStyledEvent new text: styledText).
	^ styledText
]

{ #category : #styling }
BrTextStyler >> styleInBackgroundProcess: aBrText [
	self styleInBackgroundProcess: aBrText andAfterDo: [ "nothing" ]
]

{ #category : #styling }
BrTextStyler >> styleInBackgroundProcess: aBrText andAfterDo: aBlock [

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
				self fireEvent: (BrTextStyledEvent new text: styledText).
				aBlock value ].
		 ] forkAt: Processor userBackgroundPriority ]
]

{ #category : #styling }
BrTextStyler >> styleInBackgroundProcessNow: aBrText [
	
	self terminateBackgroundStylingProcess.
	
	stylingEnabled
		ifFalse: [ ^ self ].

	self monitor critical: [
		backgroundProcess := [
			| styledText |
			text := aBrText unstyle.
			styledText := self privateStyle: text.
			BlUniverse defer: [ self fireEvent: (BrTextStyledEvent new text: styledText) ].
		 ] forkAt: Processor userBackgroundPriority ]
]

{ #category : #styling }
BrTextStyler >> styledTextFor: aText [ 
	^self privateStyle: aText
]

{ #category : #private }
BrTextStyler >> stylingEnabled [
	^ stylingEnabled
]

{ #category : #private }
BrTextStyler >> stylingEnabled: aBoolean [
	stylingEnabled := aBoolean
]

{ #category : #private }
BrTextStyler >> terminateBackgroundStylingProcess [
	self monitor critical: [
		backgroundProcess ifNotNil: [
			backgroundProcess terminate.
			backgroundProcess := nil ] ]
]

{ #category : #styling }
BrTextStyler >> unstyledTextFrom: aBrText [ 
	^ aBrText unstyled
]

{ #category : #accessing }
BrTextStyler >> view: aViewOrMorph [ 
	view := aViewOrMorph
]
