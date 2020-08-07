/// @description Various methods of hack detection

if (HackCheck_HackInstalled()) {
    // The user has a version of Lucky Patcher installed
}

if (HackCheck_Signature("XXYYZZAABBCC")) {
    // the user has modified the app
    // could have removed adverts, In-app purchases or more
}

/*
    To find your signature ("XXYYZZAABBCC"):
    compile the game for android as if you were going to release it,
    placing the function HackCheck_ShowCertificate() so that it will
    be called. A popup will show, which you can copy your certificate
    out of. In the example, you would replace "XXYYZZAABBCC" with
    this string.
*/

/* */
/*  */
