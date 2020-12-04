Class {
	#name : #BlElementExternalProperties,
	#superclass : #BlElementProperties,
	#instVars : [
		'properties'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #adding }
BlElementExternalProperties >> addProperties: aCollectionOfBlElementProperty [
	aCollectionOfBlElementProperty do: [ :eachProperty | self addProperty: eachProperty ]
]

{ #category : #adding }
BlElementExternalProperties >> addProperty: aBlElementProperty [
	properties
		at: aBlElementProperty type
		put: aBlElementProperty
]

{ #category : #initialization }
BlElementExternalProperties >> initialize [
	super initialize.
	
	properties := IdentityDictionary new
]

{ #category : #accessing }
BlElementExternalProperties >> properties [
	^ properties
]

{ #category : #removing }
BlElementExternalProperties >> removeProperties: aCollectionOfElementProperties [
	aCollectionOfElementProperties do: [ :eachProperty | self removeProperty: eachProperty ]
]

{ #category : #'adding / removing' }
BlElementExternalProperties >> removeProperty: aBlElementProperty [
	properties
		removeKey: aBlElementProperty type
		ifAbsent: [
			properties
				keysAndValuesRemove: [ :eachPropertyType :eachProperty |
					eachProperty = aBlElementProperty ] ]
]
