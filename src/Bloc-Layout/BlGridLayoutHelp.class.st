"
A helper class containing the help for Grid layout.
"
Class {
	#name : #BlGridLayoutHelp,
	#superclass : #Object,
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #accessing }
BlGridLayoutHelp class >> bookName [ 
	^'Grid Layout'
]

{ #category : #accessing }
BlGridLayoutHelp class >> key [
	^ self name
]

{ #category : #pages }
BlGridLayoutHelp class >> license [
	"This method was automatically generated."
	^ HelpTopic
		title: 'License'
		contents: 
'Copyright (C) 2011 The Android Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.!' readStream nextChunkText
]

{ #category : #accessing }
BlGridLayoutHelp class >> pages [
	^#(license)
]
