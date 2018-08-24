"
I contain experimental examples that only work in manually prepared laboratory environments.

Trying to run these examples may result in undefined bahaviour such as: crash, infinite debugger windows spawning, unresponsive image, universe collapse or suddenly created black hole that will probably destroy our solar system.

Take care. Be conscious at all times.
"
Class {
	#name : #BlExperimentalExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Experimental'
}

{ #category : #examples }
BlExperimentalExamples class >> example3D [
	| space |
	space := BlSpace new
		extent: 600 @ 450;
		title: '3D example'.

	space root
		addChild: (self newCube3D relocate: 25@25);
		yourself.

	space root addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	space show
]

{ #category : #'instance creation' }
BlExperimentalExamples class >> newCube3D [

	^ BlElementExampleCubeOpenGL new
		size: 550@400;
		yourself
]
