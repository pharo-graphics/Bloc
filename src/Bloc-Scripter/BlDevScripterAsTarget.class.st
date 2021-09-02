"
I am a copy of class BlDevScripterModelTarget. This comment is copied from there, and might not be entirely accurate

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
	#name : 'BlDevScripterAsTarget',
	#superclass : 'BlDevScripterTarget',
	#category : 'Bloc-Scripter-Scripter-Targets'
}

{ #category : 'searching' }
BlDevScripterAsTarget >> findTargetIn: anElement [
	<return: #BlElement>
	AssertionFailure signal: 'Scripter cannot be accessed from an element'
]

{ #category : 'searching' }
BlDevScripterAsTarget >> findTargetStartingInScripter: aScripter [
	^ aScripter
]

{ #category : 'accessing' }
BlDevScripterAsTarget >> identifier [
	^ 'model'
]

{ #category : 'printing' }
BlDevScripterAsTarget >> printOn: aStream [
	aStream nextPutAll: 'Scripter Model'.
]
