Class {
	#name : #BlGlutinWindowEventsSensor,
	#superclass : #GlutinWindowEventsSensor,
	#instVars : [
		'eventQueue'
	],
	#category : #'BlocHost-Glutin'
}

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> allEventsDo: aBlock [
	"Return the next event from the receiver."
	| aGlutinWindowEvent |

	 [ aGlutinWindowEvent := eventQueue nextOrNil ] whileNotNil: [
		aGlutinWindowEvent ifNotNil: aBlock
	]
]

{ #category : #initialization }
BlGlutinWindowEventsSensor >> initialize [
	super initialize.

	eventQueue := WaitfreeQueue new
]

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> nextEventDo: aBlock [
	"Return the next event from the receiver."
	| aGlutinWindowEvent |

	aGlutinWindowEvent := eventQueue nextOrNil.
	aGlutinWindowEvent ifNotNil: aBlock
]

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> processGlutinEvent: aGlutinWindowEvent forWindow: aWindow [
	| anEventCopy anEventData |
	
	(aGlutinWindowEvent isKindOf: GlutinWindowResizedEvent)
		ifTrue: [ ^ self ].

	anEventData := (1 to: aGlutinWindowEvent class structureSize)
		collect: [ :i | aGlutinWindowEvent getHandle unsignedByteAt: i ] as: ByteArray.
	anEventCopy := aGlutinWindowEvent class new.
	anEventCopy setHandle: anEventData.
	anEventCopy windowId: aGlutinWindowEvent windowId.

	eventQueue nextPut: anEventCopy
]
