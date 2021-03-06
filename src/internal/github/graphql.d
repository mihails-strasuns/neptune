/*******************************************************************************

    Varios functions to interact with githubs graphql api

    Copyright:
        Copyright (c) 2018 dunnhumby Germany GmbH. All rights reserved.

    License:
        Boost Software License Version 1.0. See LICENSE.txt for details.

*******************************************************************************/

module internal.github.graphql;

import provider.api.Repos;
import provider.core;

import vibe.data.json;

/*******************************************************************************

    Perform a graph QL query

    Params:
        connection = connection to use
        query      = query

    Returns:
        query result

*******************************************************************************/

auto graphQL ( ref HTTPConnection con, string query )
{
    import vibe.data.json;
    import provider.media;

    Json data = Json.emptyObject;

    data["query"] = query;

    return con.post("/graphql", data, MediaType.Default);
}
