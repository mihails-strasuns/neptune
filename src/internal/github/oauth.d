/*******************************************************************************

    Oauth related github remote methods

    Copyright:
        Copyright (c) 2017 dunnhumby Germany GmbH. All rights reserved.

    License:
        Boost Software License Version 1.0. See LICENSE.txt for details.

*******************************************************************************/

module internal.github.oauth;

/*******************************************************************************

    Uses the given user/pass to create a connection which is then used to setup
    an oauth token with the given scopes and note

    Params:
        user = github username
        pass = github password
        scopes = oauth permission scopes
        note = oauth note

    Returns:
        oauth token code

*******************************************************************************/

public string createOAuthToken ( string user, string pass,
                                 string[] scopes, string note )
{
    import vibe.data.json;
    import provider.core;

    Configuration cfg;

    cfg.dryRun = false;
    cfg.username = user;
    cfg.password = pass;

    auto connection = HTTPConnection.connect(cfg);

    Json json = Json.emptyObject;

    json["scopes"] = Json.emptyArray;

    foreach (_scope; scopes)
        json["scopes"] ~= _scope;

    json["note"] = note;

    auto response = connection.post("/authorizations", json);

    return response["token"].to!string;
}
