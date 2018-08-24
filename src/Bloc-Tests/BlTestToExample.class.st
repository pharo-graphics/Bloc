"
I convert unit tests to GT-Examples
"
Class {
	#name : #BlTestToExample,
	#superclass : #Object,
	#category : 'Bloc-Tests'
}

{ #category : #actions }
BlTestToExample >> convert: aClass [
	| tests |
	tests := aClass methods select: [ :aCompiledMethod |
	(aCompiledMethod selector beginsWith: 'test')
		and: [ (aCompiledMethod pragmaAt: #gtExample) isNil ] ].

	tests collect: [ :aCompiledMethod |
		| source lines break startIndex |
		source := aCompiledMethod sourceCode.
		break := false.
		lines := source lines asOrderedCollection.
		startIndex := lines
			detectIndex: [ :aString | aString matchesRegex: '\s*\|.*\|\s*' ]
			ifNone: [ 1 ].
		
		lines add: '	<gtExample>' afterIndex: startIndex.
		lines add: '	self setUp.' afterIndex: startIndex + 1.
		lines reverseWithIndexDo: [ :aString :index |
			(break not and: [ aString isAllSeparators not and: [ (aString endsWith: '.') not ] ])
				ifTrue: [ lines at: index put: (aString, '.'). break := true ] ].
		lines add: ''.
		lines add: '	self tearDown'.
		
		source := lines inject: nil into: [ :str :each |
			str ifNil: [ each ] ifNotNil: [ str, String cr, each ] ].
		aCompiledMethod methodClass compile: source ]
]
