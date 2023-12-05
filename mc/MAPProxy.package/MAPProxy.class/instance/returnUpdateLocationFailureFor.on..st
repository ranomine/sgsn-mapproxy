as yet unclassified
returnUpdateLocationFailureFor: aRequest on: aDelegate
	| error |

	logger logError: 'updateLocation failed' with: { 'imsi' ->  aRequest mobileIdentity fromTBCD}.

	"TODO: handle the cause better"
	error := MAPProxyUpdateLocationError new.
	error mobileIdentity: aRequest mobileIdentity.
	aDelegate sendGSUP: error toMessage asByteArray.