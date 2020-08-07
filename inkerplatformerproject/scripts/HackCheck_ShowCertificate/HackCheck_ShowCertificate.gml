/// @description HackCheck_ShowCertificate()
function HackCheck_ShowCertificate() {
	// Shows the certificate. Do not call this in your release version
	get_string_async("This is your signature to use when calling the signature checking function", _HackCheck_GetSignature());



}
