"
BlSpaceRenderSignal is used to record the start and end times of space rendering.  These can then be analysed and spaces that are slow, and thus are significantly impacting the frame rate, identified.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	space:		<Object>


    Implementation Points

"
Class {
	#name : 'BlSpaceRenderSignal',
	#superclass : 'BeaconSignal',
	#instVars : [
		'space',
		'action'
	],
	#classVars : [
		'Ignore'
	],
	#package : 'Bloc',
	#tag : 'Space - Support'
}

{ #category : 'filtering' }
BlSpaceRenderSignal class >> dontIgnore [

	Ignore := false.
]

{ #category : 'instance creation' }
BlSpaceRenderSignal class >> endSpace: aSpace [

	^self new 
		space: aSpace;
		action: #end;
		emit
]

{ #category : 'instance creation' }
BlSpaceRenderSignal class >> for: aSpace block: aBlock [

	Ignore == false ifFalse:
		[  ^aBlock value ].
	self startSpace: aSpace.
	aBlock value.
	self endSpace: aSpace.
]

{ #category : 'instance creation' }
BlSpaceRenderSignal class >> fromSton: stonReader [

	| signal |

	signal := self new.
	stonReader parseListDo: [ :each :idx |
		idx = 1 ifFalse: [ self error: 'Invalid STON' ].
		signal
			basicTimestamp: (each at: #timestamp);
			basicProcessId: (each at: #processId);
			basicProperties: (each at: #properties);
			space: (each at: #space);
			action: (each at: #action) ].
	^signal
]

{ #category : 'filtering' }
BlSpaceRenderSignal class >> ignore [
	"Don't emit the signal"
	
	Ignore := true.
]

{ #category : 'instance creation' }
BlSpaceRenderSignal class >> startSpace: aSpace [

	^self new 
		space: aSpace;
		action: #start;
		emit
]

{ #category : 'accessing' }
BlSpaceRenderSignal >> action [
	^ action
]

{ #category : 'accessing' }
BlSpaceRenderSignal >> action: anObject [
	action := anObject
]

{ #category : 'ston persistence' }
BlSpaceRenderSignal >> asDictionary [

	| spaceSton |

	spaceSton := String streamContents: [ :stream |
		stream 
			print: space identityHash;
			<< '-';
			print: space ].
	^super asDictionary 
		at: #space put: spaceSton;
		at: #action put: action;
		yourself.
]

{ #category : 'printing' }
BlSpaceRenderSignal >> printOneLineContentsOn: stream [

	stream
		print: action;
		<< ': ';
		print: space.

]

{ #category : 'accessing' }
BlSpaceRenderSignal >> space [
	^ space
]

{ #category : 'accessing' }
BlSpaceRenderSignal >> space: anObject [
	space := anObject
]

{ #category : 'accessing' }
BlSpaceRenderSignal >> target [
	"Answer the object that is the target of this signal"

	^space
]
