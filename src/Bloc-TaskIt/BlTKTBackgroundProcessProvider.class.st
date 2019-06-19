"
BlTKTBackgroundProcessProvider is a TKTTaskItProcessProvider that creates the smalltalk processes at low priority, see #createProcessDoing:named:.

Public API and Key Messages

The Public API and Key Messages are the same as for my superclass.

"
Class {
	#name : #BlTKTBackgroundProcessProvider,
	#superclass : #TKTTaskItProcessProvider,
	#category : #'Bloc-TaskIt-Processes'
}

{ #category : #'instance-creation' }
BlTKTBackgroundProcessProvider >> createProcessDoing: aValuable named: aName [
	^ (TKTProcess send: #value to: aValuable)
		annotate: #task with: aValuable;
		name: aName;
		priority: Processor userSchedulingPriority - 5;
		run
]
