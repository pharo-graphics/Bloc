"
I am a concrete visibility type - ""hidden"".
Once set, element should not be rendered but should participate in layout and take space.

"
Class {
	#name : 'BlVisibilityHidden',
	#superclass : 'BlVisibility',
	#package : 'Bloc',
	#tag : 'Basic-Properties'
}

{ #category : 'testing' }
BlVisibilityHidden >> isHidden [
	^ true
]
