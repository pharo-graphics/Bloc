"
I am a copy of class BlHorizontalCoordinateAlignment. This comment is copied from there, and might not be entirely accurate

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

    Instance Variables
	coordinate:		<Object>
	relativeAlignment:		<Object>


    Implementation Points

"
Class {
	#name : 'BlVerticalCoordinateAlignment',
	#superclass : 'BlVerticalAlignment',
	#instVars : [
		'coordinate',
		'relativeAlignment'
	],
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'accessing' }
BlVerticalCoordinateAlignment >> coordinate [
	^ coordinate
]

{ #category : 'accessing' }
BlVerticalCoordinateAlignment >> coordinate: anObject [
	coordinate := anObject
]

{ #category : 'factory' }
BlVerticalCoordinateAlignment >> directed: aBlLayoutDirection [
	^ aBlLayoutDirection of: self
]

{ #category : 'initialization' }
BlVerticalCoordinateAlignment >> initialize [
	super initialize.
	
	coordinate := 0.0.
	relativeAlignment := BlElementAlignment horizontal center
]

{ #category : 'factory' }
BlVerticalCoordinateAlignment >> leftToRight [
	^ self class new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment leftToRight
]

{ #category : 'accessing' }
BlVerticalCoordinateAlignment >> relativeAlignment [
	^ relativeAlignment
]

{ #category : 'accessing' }
BlVerticalCoordinateAlignment >> relativeAlignment: anObject [
	relativeAlignment := anObject
]

{ #category : 'factory' }
BlVerticalCoordinateAlignment >> rightToLeft [
	^ self class new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment rightToLeft
]
