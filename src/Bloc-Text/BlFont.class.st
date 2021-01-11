Class {
	#name : #BlFont,
	#superclass : #Object,
	#traits : 'TBlFontDescriptor + TBlFont',
	#classTraits : 'TBlFontDescriptor classTrait + TBlFont classTrait',
	#category : #'Bloc-Text-Font'
}

{ #category : #accessing }
BlFont >> font [
	<return: #TBlFont>

	^ self
]
