"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBloc,
	#superclass : #PackageManifest,
	#category : #'Bloc-Manifest'
}

{ #category : #'code-critics' }
ManifestBloc class >> ruleRBNotEliminationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BlRope #isNotEmpty #false)) #'2019-01-05T19:54:41.211552+01:00') )
]
