"
I am a special type of presentation that allowes users to create presentations using installable frameworks.
When used framework is not installed I show a dialog asking users if they would like to install that framework
"
Trait {
	#name : #TGLMBlocPresentation,
	#category : #'Bloc-Extensions-Presentations'
}

{ #category : #'api - instance creation' }
TGLMBlocPresentation >> element [
	"Create a bloc element to be displayed as a visual representation of this presentation"
	<return: #BlElement>
	
	^ BlElement new
]

{ #category : #'api - testing' }
TGLMBlocPresentation >> isAvailable [
	"Return true if this presentation is available"
	<return: #Boolean>

	^ self subclassResponsibility
]
