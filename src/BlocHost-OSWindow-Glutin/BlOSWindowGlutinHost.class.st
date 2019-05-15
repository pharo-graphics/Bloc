Class {
	#name : #BlOSWindowGlutinHost,
	#superclass : #BlOSWindowHost,
	#category : #'BlocHost-OSWindow-Glutin'
}

{ #category : #'driver selection' }
BlOSWindowGlutinHost class >> isSupported [
	^ GlutinLibrary uniqueInstance hasModule
]

{ #category : #'driver selection' }
BlOSWindowGlutinHost class >> label [
	"Return a host name that we can refer to. May be used for settings"
	<return: #String>

	^ 'OSWindow - Glutin'
]

{ #category : #'driver selection' }
BlOSWindowGlutinHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 10
]

{ #category : #initialization }
BlOSWindowGlutinHost >> keyboardKeyTable [
	^ BlOSWindowGlutinKeyboardKeyTable default
]

{ #category : #'host - events' }
BlOSWindowGlutinHost >> pollEvents [
	OSGlutinDriver pollEvents
]

{ #category : #initialization }
BlOSWindowGlutinHost >> preferableDriver [
	<return: #OSWindowDriver>

	^ OSGlutinDriver new
]
