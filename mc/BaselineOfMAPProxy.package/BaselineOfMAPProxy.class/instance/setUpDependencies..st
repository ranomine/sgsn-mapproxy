as yet unclassified
setUpDependencies: spec

	spec
		baseline: 'OsmoCore'
		with: [ spec repository: 'github://moiji-mobile/osmocom-core:v9/source' ].
	spec
		baseline: 'TCAP'
		with: [ spec
				repository: 'github://ranomine/tcap:pharo10/source';
				loads: #('default' 'camel') ].
	spec
		baseline: 'OsmoLogging'
		with: [ spec repository: 'github://moiji-mobile/osmocom-logging:v8/source' ].
	spec
		baseline: 'OsmoNetwork'
		with: [ spec repository: 'github://moiji-mobile/osmocom-network:v10/source' ].
	spec
		baseline: 'OsmoCrashReportClient'
		with: [ spec
				repository: 'github://moiji-mobile/osmocom-crashreport:v7/source' ].
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec
				repository: 'github://svenvc/zinc:v5/repository';
				loads: #('REST') ].
	spec
		baseline: 'OsmoGSM'
		with: [ spec repository: 'github://moiji-mobile/osmocom-gsm:v3/source' ].
