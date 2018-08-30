"
GtInspector openOn: BlTaskItDemoCommand new
"
Class {
	#name : #BlTaskItDemoCommand,
	#superclass : #BlCommand,
	#instVars : [
		'cancelRequested',
		'wasCanceled'
	],
	#category : #'Bloc-TaskIt'
}

{ #category : #'api - execution' }
BlTaskItDemoCommand >> cancelRequest [
	"Every command is responsible to terminate nicely"
	cancelRequested := true.
]

{ #category : #'api - execution' }
BlTaskItDemoCommand >> execute [
	1 to: 20 do: [ :each |
		cancelRequested ifTrue: [ wasCanceled := true. ^ self ].
		(Delay forMilliseconds: 100) wait ]. 
	1 to: 20 do: [ :each |
		cancelRequested ifTrue: [ wasCanceled := true. ^ self ].
		BlProgress signal: 'Transferring...' amount: each * 1024 total: 20*1024.
		(Delay forMilliseconds: 100) wait ]
]

{ #category : #'gt-extension' }
BlTaskItDemoCommand >> gtLong2LastingComputacionFor: aView [
	<gtView>
	^ aView taskItExplicit 
		title: 'Looong 2';
		priority: 4;
		stencil: [ 
			6 seconds wait.
			BlTextElement new
				text: 'Finished' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'gt-extension' }
BlTaskItDemoCommand >> gtLongLastingComputacionFor: aView [
	<gtView>
	^ aView taskItExplicit 
		title: 'Looong';
		priority: 3;
		stencil: [ 
			3 seconds wait.
			BlTextElement new
				text: 'Finished' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'gt-extension' }
BlTaskItDemoCommand >> gtShort2LastingComputacionFor: aView [
	<gtView>
	^ aView taskItExplicit 
		title: 'Short 2';
		priority: 2;
		stencil: [ 
			BlTextElement new
				text: 'I am fast too' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'gt-extension' }
BlTaskItDemoCommand >> gtShortLastingComputacionFor: aView [
	<gtView>
	^ aView taskItExplicit 
		title: 'Short';
		priority: 1;
		stencil: [ 
			BlTextElement new
				text: 'I am fast' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #initialization }
BlTaskItDemoCommand >> initialize [
	super initialize.
	cancelRequested := false.
	wasCanceled := false.
]

{ #category : #'api - execution' }
BlTaskItDemoCommand >> result [
	"I do not have a meanigful result"
	^ nil
]

{ #category : #'api - testing' }
BlTaskItDemoCommand >> wasCanceled [
	"Answer whether an execution was canceled"
	<return: #Boolean>
	^ wasCanceled
]
