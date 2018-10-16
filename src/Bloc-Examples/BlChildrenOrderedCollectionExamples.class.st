"
I define examples for the class ${class:BlChildrenOrderedCollection}$.

Instances of ${class:BlChildrenOrderedCollection}$ are created by directly instatiating the class.
${example:BlChildrenOrderedCollectionExamples>>#emptyChildrenExplicitCreation}$

Bloc elements can then be added and removed from the collection.
${example:BlChildrenOrderedCollectionExamples>>#add}$

${example:BlChildrenOrderedCollectionExamples>>#remove}$
"
Class {
	#name : #BlChildrenOrderedCollectionExamples,
	#superclass : #Object,
	#traits : 'TBlChildrenExample',
	#classTraits : 'TBlChildrenExample classTrait',
	#category : #'Bloc-Examples-Children'
}

{ #category : #'examples - children' }
BlChildrenOrderedCollectionExamples >> emptyChildrenExplicitCreation [
	<gtExample>
	| theChildren |

	theChildren := BlChildrenOrderedCollection new.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.

	^ theChildren
]

{ #category : #'instance creation' }
BlChildrenOrderedCollectionExamples >> newChildrenCollection [
	^ BlChildrenOrderedCollection new
]
