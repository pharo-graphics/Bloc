Class {
	#name : #BlTaskProcess,
	#superclass : #Process,
	#instVars : [
		'processAnnotation'
	],
	#category : #'Bloc-TaskIt-Processes'
}

{ #category : #accessing }
BlTaskProcess >> annotate: aTag with: aValue [
	self processAnnotation at: aTag put: aValue.
]

{ #category : #accessing }
BlTaskProcess >> annotation: aTag [
	^ self processAnnotation at: aTag ifAbsent: [ nil ]
]

{ #category : #accessing }
BlTaskProcess >> hasProcessAnnotations [
	^ processAnnotation notNil and: [ processAnnotation isNotEmpty ]
]

{ #category : #accessing }
BlTaskProcess >> processAnnotation [
	^ processAnnotation ifNil: [ processAnnotation := WeakValueDictionary new ]
]

{ #category : #accessing }
BlTaskProcess >> task [
	^ self annotation: #task
]

{ #category : #accessing }
BlTaskProcess >> task: aValuable [
	^ self annotate: #task with: aValuable
]
