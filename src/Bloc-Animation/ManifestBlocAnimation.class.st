"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBlocAnimation,
	#superclass : #PackageManifest,
	#category : 'Bloc-Animation'
}

{ #category : #'meta-data' }
ManifestBlocAnimation class >> description [ ^ 'I am Animation framework used with Bloc.

I contain a concrete implementation of BlAnimation and various useful types if it, for example rotation, scaling and translation animations.
In order to make animations work I provide many types of most popular interpolators or so called easing functions.
They are used by Animations to provide smooth value transitions'
]
