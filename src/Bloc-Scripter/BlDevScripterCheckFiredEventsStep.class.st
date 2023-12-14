"
I check whether particular `BlEvent` events were fired on a `BlElement` target.

## Example

Here you can see how to configure a fire and check a click event on a child element:
`BlDevScripterExamples>>#clickCheck`
"
Class {
	#name : 'BlDevScripterCheckFiredEventsStep',
	#superclass : 'BlDevScripterCheckStep',
	#instVars : [
		'events'
	],
	#category : 'Bloc-Scripter-Scripter-Steps',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Steps'
}

{ #category : 'asserting' }
BlDevScripterCheckFiredEventsStep >> assertEventClass: anEventClass withTarget: aBlElement on: aScripter [ 
	| theInterestingEvents |
	theInterestingEvents := aScripter events select: [ :eachEvent | 
		(eachEvent isKindOf: anEventClass) and: [
			eachEvent target = aBlElement ] ].
	self assert: theInterestingEvents notEmpty
]

{ #category : 'accessing' }
BlDevScripterCheckFiredEventsStep >> defaultLabel [
	^ 'Click Check'
]

{ #category : 'accessing' }
BlDevScripterCheckFiredEventsStep >> event: aClass [ 
	self events: { aClass }
]

{ #category : 'accessing' }
BlDevScripterCheckFiredEventsStep >> events [
	<return: #Collection of: #BlEvent>

	^ events
]

{ #category : 'accessing' }
BlDevScripterCheckFiredEventsStep >> events: aCollection [
	<return: #Collection of: #BlEvent>
	self 
		assert: [ aCollection isCollection and: [ aCollection isNotEmpty ] ]
		description: [ 'Collection of events must be non-empty' ].
	events := aCollection
]

{ #category : 'actions' }
BlDevScripterCheckFiredEventsStep >> playOn: aScripter [
	| anElement |

	self
		assert: [ self events isCollection and: [ self events isNotEmpty ] ]
		description: [ 'Expected events must be defined' ]. 
	anElement := self target findTargetStartingInScripter: aScripter.
	self events do: [ :eachEventClass | 
		self assertEventClass: eachEventClass withTarget: anElement on: aScripter ].
]
