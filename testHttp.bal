import ballerina/http;

service /greetings on new http:Listener(8080) {
    resource function get hello(http:Caller caller, http:Request req) returns error? {
        check caller->respond("HEllo Niklesh Welcome to Ballerina and WSO2!!!");
    }
}
