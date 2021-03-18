"
I am an abstract Bloc OSWindow renderer. 
"
Class {
	#name : #BlOSWindowRenderer,
	#superclass : #OSWindowGLRenderer,
	#instVars : [
		'surface'
	],
	#category : #'BlocHost-OSWindow-Support'
}

{ #category : #'updating screen' }
BlOSWindowRenderer >> exposed [
]

{ #category : #'updating screen' }
BlOSWindowRenderer >> resized [
	
]

{ #category : #'updating screen' }
BlOSWindowRenderer >> updateAll [
	self shouldNotImplement
]

{ #category : #'updating screen' }
BlOSWindowRenderer >> updateRectangle: aRectangle [
	self shouldNotImplement
]

{ #category : #'updating screen' }
BlOSWindowRenderer >> updateRectangles: allDamage [
	self shouldNotImplement
]
