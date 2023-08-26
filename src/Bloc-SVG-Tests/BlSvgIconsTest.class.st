"
A BlSvgIconsTest is a test class for testing the behavior of BlSvgIcons
"
Class {
	#name : #BlSvgIconsTest,
	#superclass : #TestCase,
	#category : #'Bloc-SVG-Tests-Examples'
}

{ #category : #tests }
BlSvgIconsTest >> testAllIcons [

	| selectors |
	selectors := BlSvgIcons iconSelectors.
	
	selectors do: [ :each |
		| result |
		result := BlSvgIcons perform: each.
		self assert: (result isKindOf: BlElement) ].
	
	self deny: selectors isEmpty.
]
