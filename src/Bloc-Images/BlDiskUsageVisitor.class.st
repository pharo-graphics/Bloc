"
BlDiskUsageVisitor simply walks over the cache files and totals up their size.

Public API and Key Messages

- on: aFileReference
- total
- entryCount

!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	entryCount:		<Integer> The number of files visited
	total:		<Integer> The total size of the cache in bytes


!!Implementation Points
"
Class {
	#name : #BlDiskUsageVisitor,
	#superclass : #FileSystemVisitor,
	#instVars : [
		'total',
		'entryCount'
	],
	#category : #'Bloc-Images-Cache'
}

{ #category : #'instance creation' }
BlDiskUsageVisitor class >> on: aFileReference [

	^self new 
		on: aFileReference;
		yourself
]

{ #category : #accessing }
BlDiskUsageVisitor >> entryCount [
	^ entryCount
]

{ #category : #initialization }
BlDiskUsageVisitor >> initialize [ 

	super initialize.
	total := 0.
	entryCount := 0.
]

{ #category : #'instance creation' }
BlDiskUsageVisitor >> on: aFileReference [

	(PreorderGuide for: self) show: aFileReference
]

{ #category : #accessing }
BlDiskUsageVisitor >> total [
	^ total
]

{ #category : #visiting }
BlDiskUsageVisitor >> visitFile: anEntry [

	total := total + anEntry size.
	entryCount := entryCount + 1.
]
