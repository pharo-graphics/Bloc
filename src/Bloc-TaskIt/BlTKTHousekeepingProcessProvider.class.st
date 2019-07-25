"
BlTKTHousekeepingProcessProvider is a TKTTaskItProcessProvider that creates the smalltalk processes at low priority, see #createProcessDoing:named:.

Public API and Key Messages

The Public API and Key Messages are the same as for my superclass.

"
Class {
	#name : #BlTKTHousekeepingProcessProvider,
	#superclass : #BlTKTTaskItProcessProvider,
	#category : #'Bloc-TaskIt-! Obsolete'
}

{ #category : #accessing }
BlTKTHousekeepingProcessProvider >> processPriority [
	<return: #Integer>
	^ Processor userBackgroundPriority
]
