import ballerina/http;

type iTunesSearchItems record {
    string collectionName;
    string collectionViewUrl;
};

type iTunesSearchResults record {
    iTunesSearchItems[] results;
};

type Album record {|
    string name;
    string url;
|};

service /pickagift on new http:Listener(8080) {
    resource function get albums(string artist) returns Album[]|error? {
        http:Client iTunes = check new ("https://itunes.apple.com");
        iTunesSearchResults search = check iTunes->get(searchUrl(artist));
        return from iTunesSearchItems i in search.results
            select {name: i.collectionName, url: i.collectionViewUrl};
    }

}

function searchUrl(string artist) returns string {
    return "/search?term=t" + artist + "&entity=album&attribute=allArtistTerm";
}

