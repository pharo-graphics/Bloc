"
I am the abstract class for a Host.
I define an environment that can be used to provide actual screen spaces and rendering.
A Host can be compared to a driver that communicates with the native multimedia API.

"
Class {
	#name : #BlHost,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Universe - Host'
}

{ #category : #'driver selection' }
BlHost class >> availableHostClasses [
	"Return all available bloc host classes sorted by their priority"
	<return: #Collection>

	^ (self allSubclasses select: [ :aHostClass | aHostClass isSupported ])
		sort: [ :a :b | a priority < b priority ]
]

{ #category : #'api - lifecycle' }
BlHost class >> isRunning [
	^ self subclassResponsibility
]

{ #category : #'driver selection' }
BlHost class >> isSupported [
	^ false
]

{ #category : #'driver selection' }
BlHost class >> label [
	"Return a host name that we can refer to. May be used for settings"

	^ self subclassResponsibility
]

{ #category : #'driver selection' }
BlHost class >> pickHost [
	"Find and instantiate a first supported host.
	Return a special null one if there are no available hosts"
	<return: #BlHost>
	
	"If setting is not set dispatches to back to me returning #defaultHostClass"
	^ Bloc preferableHostClass new
]

{ #category : #'driver selection' }
BlHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	A lower value is more likely to become the default host."
	
	^ self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost class >> start [

	self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost class >> stop [

	self subclassResponsibility
]

{ #category : #'driver selection' }
BlHost class >> suitableHostClass [
	"Find my most suitable subclass, as a default candidate.
	Return `BlHeadlessHost` if there are no available hosts."

	^ self availableHostClasses
		"There are no availbale hosts, return a null one"
		ifEmpty: [ BlHeadlessHost ]
		ifNotEmpty: [ :theHostClasses | theHostClasses first ]
]

{ #category : #'api - ui process' }
BlHost class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
]

{ #category : #'host space - accessing' }
BlHost class >> universe [

	^ BlParallelUniverse forHost: self
]

{ #category : #'host - api' }
BlHost >> createHostSpaceFor: aSpace [

	self subclassResponsibility
]

{ #category : #'host - api' }
BlHost >> destroyHostSpaceFor: aSpace [
	"Destroys host space window of a given space.
	Note: in most cases under 'destroy host space' we mean 'close host window' and unregister it"
	
	self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost >> isRunning [
	"Return true if host is initialized and running"

	^ self class isRunning
]

{ #category : #'host - testing' }
BlHost >> isStillAvailable [
	"Let's assume that a space is opened with me as a host.
	I return true if I am still available host for the current system.
	For example if a space is opened in a native window with a headless VM
	and then reopened with a headfull VM all those spaces should be re-opened
	with a different host, for example morphic"

	^ true
]

{ #category : #'paragraph - measuring' }
BlHost >> offscreenMeasureTextParagraph: aBlTextParagraph [ 
	"Update the received paragraph with its measurement."

	BlHostRenderer preferableClass offscreenMeasureTextParagraph: aBlTextParagraph
]

{ #category : #'api - lifecycle' }
BlHost >> start [

	self class start
]

{ #category : #'api - lifecycle' }
BlHost >> stop [

	self class stop
]

{ #category : #'host - testing' }
BlHost >> supportsBufferSurface [
	"Return true if this host can work with buffer surface, false otherwise"
	
	^ false
]

{ #category : #'host - testing' }
BlHost >> supportsFormSurface [
	"Return true if this host can work with form surface, false otherwise"
	
	^ false
]

{ #category : #'host - testing' }
BlHost >> supportsOpenGLSurface [
	"Return true if this host can work with OpenGL surface, false otherwise"
	
	^ false
]

{ #category : #enumerating }
BlHost >> uiProcessDo: aBlock [

	self class uiProcessDo: aBlock
]

{ #category : #'host space - accessing' }
BlHost >> universe [
	
	^ self class universe
]
