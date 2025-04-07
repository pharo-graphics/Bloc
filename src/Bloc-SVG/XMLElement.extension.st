Extension { #name : #XMLElement }

{ #category : #'*Bloc-SVG' }
XMLElement >> attributeAt: aName ifPresent: aBlock [
	"returns the value of the attribute whose full name matches aName or the
	value of aBlock if there isn't any"

	| aValue |
	aValue :=
		self attributeNodes
			attributeValueAt: aName
			ifAbsent: [ ^ self ].
	^ aBlock cull: aValue
]

{ #category : #'*Bloc-SVG' }
XMLElement >> attributeAt: aName ifPresent: aBlock ifAbsent: absentBlock [
	"returns the value of the attribute whose full name matches aName or the
	value of aBlock if there isn't any"

	| aValue |
	aValue :=
		self attributeNodes
			attributeValueAt: aName
			ifAbsent: [ ^ absentBlock value ].
	^ aBlock cull: aValue
]

{ #category : #'*Bloc-SVG' }
XMLElement >> inheritAttributes [

	self isRoot ifTrue: [ ^ self ].

	self parent attributeNamesAndValuesDo: [ :key :value |
		(self shouldInheritAttribute: key) ifTrue: [
			self attributeAt: key ifAbsentPut: value ] ].

	self inheritTransformAttribute
]

{ #category : #'*Bloc-SVG' }
XMLElement >> inheritTransformAttribute [

	self parent attributeAt: 'transform' ifAbsent: [ ^ self ].

	self
		attributeAt: 'transform'
		put: (self parent attributeAt: 'transform'), self transformAttribute
]

{ #category : #'*Bloc-SVG' }
XMLElement >> readElementBy: aSVGFactory withParent: parentElement [

	| newElement |
	newElement := aSVGFactory readElementFrom: self.
	self shouldBeAddedToParent ifTrue: [
		parentElement addChild: newElement ].
	^ newElement
]

{ #category : #'*Bloc-SVG' }
XMLElement >> shouldBeAddedToParent [

	^ #('svg' 'g' 'use' 'rect' 'circle' 'ellipse' 'line' 'polyline' 'polygon' 'path' 'text' 'tspan' 'image')
			includes: self name
]

{ #category : #'*Bloc-SVG' }
XMLElement >> shouldInheritAttribute: key [
	"Note that the 'transform' attribute will still be inherited but through a special way."

	^ (#('transform' 'display' 'x' 'y' 'height' 'width' 'id' 'opacity') includes: key) not
]

{ #category : #'*Bloc-SVG' }
XMLElement >> splitStyleAttribute [

	self attributeAt: 'style' ifAbsent: [ ^ self ].

	((self attributeAt: 'style') substrings: ';') do: [ :keyAndValue |
		self
			attributeAt: (keyAndValue copyUpTo: $:) trimBoth
			put: (keyAndValue copyAfter: $:) trimBoth ]
]

{ #category : #'*Bloc-SVG' }
XMLElement >> transformAttribute [

	^ self attributeAt: 'transform' ifAbsent: [ '' ]
]
