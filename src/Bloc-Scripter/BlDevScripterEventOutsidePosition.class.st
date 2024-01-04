"
I am a copy of class BlDevScripterEventCenteredPosition. This comment is copied from there, and might not be entirely accurate

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points

"
Class {
	#name : #BlDevScripterEventOutsidePosition,
	#superclass : #BlDevScripterEventPosition,
	#category : 'Bloc-Scripter-Scripter-Event Positions'
}

{ #category : #'debug - simulation' }
BlDevScripterEventOutsidePosition >> locationOutside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	theBounds := anElement bounds inSpace bounds.
	aPosition := {
		theBounds topRight - (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds topRight + (100 atRandom @ theBounds height asInteger atRandom).
		theBounds bottomLeft + (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds bottomLeft - (100 atRandom @ theBounds height asInteger atRandom).
	}	atRandom.
		
	self
		assert: [ (theBounds containsPoint: aPosition) not ]
		description: [ 'Point must be outside of the bounds' ].
		
	^ aPosition
]

{ #category : #setup }
BlDevScripterEventOutsidePosition >> updateEventPosition: aBlEvent in: anElement [
	| aPosition |
	aPosition := self locationOutside: anElement.
	aBlEvent position: aPosition.
]
