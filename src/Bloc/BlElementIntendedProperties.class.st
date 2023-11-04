Class {
	#name : #BlElementIntendedProperties,
	#superclass : #BlElementProperties,
	#instVars : [
		'properties'
	],
	#category : 'Bloc-Basic-Properties'
}

{ #category : 'adding' }
BlElementIntendedProperties >> addProperties: aCollectionOfBlElementProperty [
	aCollectionOfBlElementProperty do: [ :eachProperty | self addProperty: eachProperty ]
]

{ #category : 'adding' }
BlElementIntendedProperties >> addProperty: aBlElementProperty [
	properties
		at: aBlElementProperty type
		put: aBlElementProperty
]

{ #category : 'initialization' }
BlElementIntendedProperties >> initialize [
	super initialize.
	
	properties := IdentityDictionary new
]

{ #category : 'copying' }
BlElementIntendedProperties >> postCopy [
	properties := properties copy
]

{ #category : 'accessing' }
BlElementIntendedProperties >> properties [
	^ properties
]

{ #category : 'removing' }
BlElementIntendedProperties >> removeProperties: aCollectionOfElementProperties [
	aCollectionOfElementProperties do: [ :eachProperty | self removeProperty: eachProperty ]
]

{ #category : 'adding / removing' }
BlElementIntendedProperties >> removeProperty: aBlElementProperty [
	properties
		removeKey: aBlElementProperty type
		ifAbsent: [
			properties
				keysAndValuesRemove: [ :eachPropertyType :eachProperty |
					eachProperty = aBlElementProperty ] ]
]
