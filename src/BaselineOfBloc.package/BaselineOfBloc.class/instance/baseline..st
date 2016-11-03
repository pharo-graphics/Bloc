as yet unclassified
baseline: spec
	<baseline>
	spec for: #common do: [ 
		 spec project: 'Sparta' with: [
				spec
					className: #BaselineOfSparta;
					versionString: 'baseline';
					loads: #(#'file:development' );
					repository: 'github://syrel/sparta/src' ];
			project: 'TaskIt' with: [
				spec
					className: #BaselineOfTaskIt;
					versionString: 'baseline';
					repository: 'github://sbragagnolo/taskit-2:dev-0.3' ];
			project: 'OSWindow' with: [
				spec
					className: #ConfigurationOfOSWindow;
					versionString: '0.8-baseline';
					repository: 'http://smalltalkhub.com/mc/Pharo/OSWindow/main/' ];
			project: 'PetitCSS' with: [
				spec
					className: #ConfigurationOfPetitCSS;
					versionString: '1.1';
					repository: 'http://smalltalkhub.com/mc/GlennCavarle/PetitCSS/main/' ].
		spec 
			package: #Bloc;
			package: 'Bloc-Animation' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-DevTool' with: [
				spec requires: #(#Bloc ). ];
			package: 'Bloc-Examples' with: [
				spec requires: #(#'Bloc-Layout' ). ];
			package: #'Bloc-Extension' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Layout' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Sparta' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Style' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Tests' with: [
				spec requires: #('Bloc-Examples' ). ];
			package: #'BlocHost-OSWindow' with: [
				spec requires: #(#Bloc ). ]. ].

