"
I capture a subset of children from a ${class:BlElement}$ instance.

I am an abstract class. My subclasses define the actual order and criteria for filtering children and iterating over the set of children.
I exist to explicitly capture and combine various ways of filtering and iterating over children. For example, ${class:BlChildrenReversed}$ indicates that the user wants to explicitly iterate over elements in reverse order; ${class:BlChildrenAccountedByLayout}$ indicates that only should children taken into account by layout should be included. 
The example below shows a scenario of combining multiple ways to iterate over children. By having an explicit object for each operation, the composition of operations can be inspected.
${example:BlChildrenSubsetExamples>>#childrenWithMultipleCombinedSubsets}$

I do not enforce a lazy API. Subclasses can perform the filtering immediately or when iteration over children is required. I aim to maintain the composition of subsets while optimizing for speed whenever possible.

!!API
Instances of me are created by calling the factory method ${method:BlChildrenSubset class>>#on:}$ on a subclass with an instance of ${class:BlChildren}$ as parameter.

Subclasses need to override the method ${method:BlChildrenSubset>>#subsetFrom:}$ to filter the elements from the given ${class:BlChildren}$ instance. This can perform no filtering, filter elements, or also change the order of elements.

!! Implementation details
Internally the result of ${method:BlChildrenSubset>>#subsetFrom:}$ is stored into an instance variable. This result is then used when accessing or iterating over elements. This decision was taken to allow iterators to perform work when the iterator is created and ensure a faster iteration.

To preserve the composition of iterators I hold a reference to the initial ${class:BlChildren}$ instance.
"
Class {
	#name : #BlChildrenSubset,
	#superclass : #BlChildren,
	#instVars : [
		'subsetArray',
		'supersetChildren'
	],
	#category : #'Bloc-Basic-Children'
}

{ #category : #'instance creation' }
BlChildrenSubset class >> on: aBlChildren [
	^ self new initializeFrom: aBlChildren
]

{ #category : #'children - accessing' }
BlChildrenSubset >> at: anIndex [
	<return: #BlElement>

	^ subsetArray at: anIndex
]

{ #category : #'children - enumerating' }
BlChildrenSubset >> do: aBlock [
	subsetArray do: aBlock
]

{ #category : #testing }
BlChildrenSubset >> hasSuperset [
	<return: #Boolean>

	 ^ true
]

{ #category : #initialization }
BlChildrenSubset >> initializeFrom: aBlChildren [
	"Store the given aBlChildren parametre to keep track of how iterators are composed and 
	also store the actual subset of elements on which this iterator will operate."
	subsetArray := self subsetFrom: aBlChildren.
	supersetChildren := aBlChildren
]

{ #category : #accessing }
BlChildrenSubset >> name [
	^ 'Subset'
]

{ #category : #'children - accessing' }
BlChildrenSubset >> size [
	<return: #Number>

	^ subsetArray size
]

{ #category : #initialization }
BlChildrenSubset >> subsetFrom: aBlChildren [
	<return: #Array of: #BlElement>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlChildrenSubset >> superset [
	"Return a superset of this children subset"
	<return: #BlChildren>
	
	^ supersetChildren
]
