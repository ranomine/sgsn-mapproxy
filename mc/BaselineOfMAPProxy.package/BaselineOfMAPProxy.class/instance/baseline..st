as yet unclassified
baseline: spec

	<baseline>
	spec for: #common do: [
			spec
				baseline: 'OsmoNetwork'
				with: [
				spec repository:
					'github://moiji-mobile/osmocom-network:v10/source' ].
			spec
				baseline: 'TCAP'
				with: [ spec repository: 'github://moiji-mobile/tcap:v12/source' ].
			spec
				baseline: 'OsmoGSM'
				with: [
				spec repository: 'github://moiji-mobile/osmocom-gsm:master/source' ].
			spec
				baseline: 'OsmoLogging'
				with: [
				spec repository: 'github://moiji-mobile/osmocom-logging:v8/source' ].
			spec
				package: 'MAPProxy'
				with: [
				spec requires: #( 'OsmoNetwork' 'OsmoLogging' 'TCAP' 'OsmoGSM' ) ] ]