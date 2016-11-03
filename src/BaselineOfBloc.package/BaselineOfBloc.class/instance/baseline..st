as yet unclassified
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			project: 'Athens' with: [
				spec
					className: #ConfigurationOfAthens;
					versionString: '2.3-baseline';
					repository: 'http://smalltalkhub.com/mc/Pharo/Athens/main/' ];	
			project: 'AthensSVG' with: [
				spec
					className: #ConfigurationOfAthensSVG;
					versionString: '1.2';
					repository: 'http://smalltalkhub.com/mc/Pharo/Athens/main/' ];	
			project: 'OSWindow' with: [
				spec
					className: #ConfigurationOfOSWindow;
					versionString: '0.8-baseline';
					repository: 'http://smalltalkhub.com/mc/Pharo/OSWindow/main/' ];
			project: 'PetitCSS' with: [
				spec
					className: #ConfigurationOfPetitCSS;
					versionString: '0.1-baseline';
					repository: 'http://smalltalkhub.com/mc/GlennCavarle/PetitCSS/main/' ];
			project: 'TxText' with: [
				spec
					className: #ConfigurationOfTxText;
					versionString: '1.0.1-baseline';
					repository: 'http://smalltalkhub.com/mc/Pharo/TxText/main' ].
		spec 
			package: #Bloc;
			package: 'Bloc-Animation' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Athens' with: [
				spec requires: #('Athens' ). ];
			package: #'Bloc-DevTool' with: [
				spec requires: #(#Bloc ). ];
			package: 'Bloc-Examples' with: [
				spec requires: #(#'Bloc-Layout' ). ];
			package: #'Bloc-Extension' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Layout' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Style' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Tests' with: [
				spec requires: #('Bloc-Examples' ). ];
			package: #'BlocHost-Morphic' with: [
				spec requires: #(#Bloc ). ];
			package: #'BlocHost-OSWindow' with: [
				spec requires: #(#Bloc ). ]. ].

