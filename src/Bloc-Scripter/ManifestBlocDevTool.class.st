"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser

"
Class {
	#name : #ManifestBlocDevTool,
	#superclass : #PackageManifest,
	#category : 'Bloc-Scripter-Manifest'
}

{ #category : #'code-critics' }
ManifestBlocDevTool class >> ruleRBCodeCruftLeftInMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BlDevScripterStep #playIndicatingStateOn: #false)) #'2019-12-10T18:00:14.330338-03:00') )
]
