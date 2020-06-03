Class {
	#name : #BlSpartaHardwareAcceleratedSpaceRenderer,
	#superclass : #BlSpartaSpaceRenderer,
	#classInstVars : [
		'useCompositor'
	],
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #accessing }
BlSpartaHardwareAcceleratedSpaceRenderer class >> defaultUseCompositor [
	^ false
]

{ #category : #settings }
BlSpartaHardwareAcceleratedSpaceRenderer class >> preferencesOn: aBuilder [
	<systemsettings>

	(aBuilder setting: #useCompositor)
		parent: #Bloc;
		target: self;
		order: 10;
		label: 'Use compositing renderer';
		description: 'When selected the hardware accelerated compositing renderer will be used (if available)';
		default: [ self defaultUseCompositor ]
]

{ #category : #accessing }
BlSpartaHardwareAcceleratedSpaceRenderer class >> useCompositor [
	^ useCompositor ifNil: [ self defaultUseCompositor ]
]

{ #category : #accessing }
BlSpartaHardwareAcceleratedSpaceRenderer class >> useCompositor: anObject [
	useCompositor := anObject
]
