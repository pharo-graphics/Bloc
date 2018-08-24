"
I am a helper class that makes it easier to import SVG icons
"
Class {
	#name : #BlSvgIconImporter,
	#superclass : #Object,
	#category : 'Bloc-SVG'
}

{ #category : #'as yet unclassified' }
BlSvgIconImporter class >> categoryNameFromFileName: aFileName [
	^ ($- split: ($. split: aFileName) first) first asLowercase
]

{ #category : #'as yet unclassified' }
BlSvgIconImporter class >> createIconClass: aClass withIcons: aCollection [
	aCollection
		do: [ :assoc | 
			assoc
				ifNotNil: [ aClass class
						compile: assoc key , 'Src' , String cr , '^''' , assoc value value , ''''
						classified: assoc value key.
					aClass class
						compile: assoc key , 'Svg' , String cr , '^ BlSvgPath fromStream: self ' , assoc key , 'Src'
						classified: assoc value key.
					aClass class
						compile: assoc key , 'Icon' , String cr , '^ self ',assoc key , 'Svg asElement'
						classified: assoc value key ] ]
]

{ #category : #'as yet unclassified' }
BlSvgIconImporter class >> iconNameFromFileName: aFileName [
^ (($.split: aFileName) first replaceAll:$-  with: Character space ) asCamelCase asValidSelector
]

{ #category : #'as yet unclassified' }
BlSvgIconImporter class >> importIn: aClass fromDir: aString [
	self
		createIconClass:aClass withIcons:
			(aString asFileReference entries
				collect: [ :each | 
					(XMLDOMParser parseFileNamed: each fullName) root allNodes
						detect: [ :n | n isElementNamed: #path ]
						ifFound: [ :n | 
							(self iconNameFromFileName: each basename)
								-> ((self categoryNameFromFileName: each basename) -> (n attributeAt: #d)) ]
						ifNone: [ nil ] ])
]
