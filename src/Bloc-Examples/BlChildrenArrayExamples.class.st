"
I define examples for the class {{gtClass:BlChildrenArray}}.

Instances of {{gtClass:BlChildrenArray}} are created by directly instatiating the class.
{{gtExample:BlChildrenArrayExamples>>#emptyChildrenExplicitCreation}}

Alternatively, instances can be created using the factory method {{gtMethod:BlChildrenArray class>>#from:}}
{{gtExample:BlChildrenArrayExamples>>#emptyChildrenFactoryMethodCreation}}

Bloc elements can then be added and removed from the collection.
{{gtExample:BlChildrenArrayExamples>>#add}}

{{gtExample:BlChildrenArrayExamples>>#remove}}

"
Class {
	#name : #BlChildrenArrayExamples,
	#superclass : #Object,
	#traits : 'TBlChildrenExample',
	#classTraits : 'TBlChildrenExample classTrait',
	#category : #'Bloc-Examples-Children'
}

{ #category : #'examples - children' }
BlChildrenArrayExamples >> emptyChildrenExplicitCreation [
	<gtExample>
	| theChildren |

	theChildren := BlChildrenArray new.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.

	^ theChildren
]

{ #category : #'examples - children' }
BlChildrenArrayExamples >> emptyChildrenFactoryMethodCreation [
	<gtExample>
	| theChildren |

	theChildren := BlChildrenArray from: {
		BlElement new.
		BlElement new.
		BlElement new
	}.
	self assert: theChildren size equals: 3.
	self assert: theChildren isNotEmpty.

	^ theChildren
]

{ #category : #'instance creation' }
BlChildrenArrayExamples >> newChildrenCollection [
	^ BlChildrenArray new
]
