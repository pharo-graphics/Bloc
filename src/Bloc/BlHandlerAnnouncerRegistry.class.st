"
I'm a handler registry based on `Announcer`.
"
Class {
	#name : #BlHandlerAnnouncerRegistry,
	#superclass : #BlHandlerRegistry,
	#instVars : [
		'announcer'
	],
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #testing }
BlHandlerAnnouncerRegistry class >> isSupported [
	
	^ true
]

{ #category : #printing }
BlHandlerAnnouncerRegistry class >> label [
	^ 'Announcer'
]

{ #category : #testing }
BlHandlerAnnouncerRegistry class >> priority [

	^ 1
]

{ #category : #'api - adding / removing' }
BlHandlerAnnouncerRegistry >> add: aHandler [
	"Adds a given event handler to the registry.
	
	Precondition: aHandler must not be already registered"

	self announcer subscriptions add: (BlHandlerAnnouncementSubscription new subscriber: aHandler)
]

{ #category : #accessing }
BlHandlerAnnouncerRegistry >> announcer [
	<return: #Announcer>

	^ announcer
]

{ #category : #'api - event managing' }
BlHandlerAnnouncerRegistry >> dispatchEvent: anEvent [
	"Dispatch a given event to all registered handlers that are interested in it"
	
	self announcer announce: anEvent
]

{ #category : #'api - enumerating' }
BlHandlerAnnouncerRegistry >> do: aBlock [
	"Evaluate aBlock with each registered handler as the argument"

	self announcer subscriptions protected: [
		self announcer subscriptions subscriptions do: [ :aSubscription | aBlock value: aSubscription subscriber ] ]
]

{ #category : #'api - accessing' }
BlHandlerAnnouncerRegistry >> handlers [
	"Return an immutable collection of all registered event handlers"
	<return: #Array of: #BlBasicEventHandler>
	
	^ self subscriptions collect: #subscriber
]

{ #category : #initialization }
BlHandlerAnnouncerRegistry >> initialize [
	super initialize.
	
	announcer := Announcer new
]

{ #category : #'api - enumerating' }
BlHandlerAnnouncerRegistry >> numberOfHandlers [
	"Return amount of registered event handlers"
	<return: #Number>

	^ self announcer numberOfSubscriptions
]

{ #category : #'api - adding / removing' }
BlHandlerAnnouncerRegistry >> remove: aHandler [
	"Remove given event handler from my registry.
	Provided handler must not be nil and must be registered"

	self announcer subscriptions removeSubscriber: aHandler
]

{ #category : #'api - adding / removing' }
BlHandlerAnnouncerRegistry >> removeAllSuchThat: aBlock [
	"Remove all event handlers for which aBlock returns true.
	Return a collection of removed handlers"
	<return: #SequenceableCollection of: #BlBasicEventHandler>
	| toBeRemoved |

	toBeRemoved := #().
	self announcer subscriptions protected: [
		toBeRemoved := self announcer subscriptions subscriptions
			select: [ :aSubscription | aBlock value: aSubscription subscriber ]
			thenCollect: [ :aSubscription | aSubscription subscriber ].
		self announcer subscriptions subscriptions removeAllSuchThat: [ :aSubscription | aBlock value: aSubscription subscriber ] ].

	^ toBeRemoved asArray
]

{ #category : #accessing }
BlHandlerAnnouncerRegistry >> subscriptions [
	<return: #Set of: #AnnouncementSubscription>

	^ self announcer subscriptions protected: [ self announcer subscriptions subscriptions copy asArray ]
]
