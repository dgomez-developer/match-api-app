

import 'package:match_api_app/auth/Credentials.dart';
import 'package:http/http.dart' as http;

import 'Cognito/src/cognito_credentials.dart';
import 'Cognito/sig_v4.dart';

class LoginApi {
  final String endpoint;
  final String path;
  final String region;
  final Credentials credentials;

  LoginApi(this.endpoint, this.path, this.region, this.credentials);

  post(Map body) async {
    CognitoCredentials cognitoCredentials = (await credentials.cognitoCredentials) as CognitoCredentials;
    final awsSigV4Client = new AwsSigV4Client(
      cognitoCredentials.accessKeyId,
      cognitoCredentials.secretAccessKey,
      endpoint,
      sessionToken: cognitoCredentials.sessionToken,
      region: region,
    );
//    final awsSigV4Client = new AwsSigV4Client(
//      "ASIAYMTXTBMLA6CAWG7N",
//      "ovdCf9UbTyjKPnlp4soaWRRe78x/bvz8ZKalRG6T",
//      endpoint,
//      sessionToken: "IQoJb3JpZ2luX2VjEEoaDGV1LWNlbnRyYWwtMSJGMEQCIH6p5dpQ/v+ZHzaidZx2zw4d16WNWDIU16W5r0jVJ3DkAiAb7FR0ge4nn1xR1tddXVEtWcZRetaLI467w4rCh6Aw/CqtAwij//////////8BEAEaDDU3Njg1MDE2ODU5OCIMUbegwhFfUXhNDndQKoEDqlmc+b/ENOpReYleoMPjn/w9oxU4/eIoJVoWsKhLPbAwYIOgsPZL7eS9wW8nXwYJiLD8IGHgfO9lJO+rnfUXlRJNFT7rPlmvc8J9i7UQMAxTWNULryG1IjA+nttJ+eMKhKpZL/DDgGhLByE1sz31GI7XEcvqryJHIaQ3v6vF12Y8XDO+gSiG532jUN6aPXPErKIVPd9M5zG+qwAkYaaepIPsgrzanyx3rKIIpK9olreZzx+KqJJVWroRcY9260R7XHQr4AvkcKXl8nQCwneQY9bymSDh5Sd0YqWL82+oXCj/vZuHkt6qcGwTUn6spK8tlBAo65ne6S5W5C7/OuzbGkxd/v6tIbV307boXKYJGzy68uVklqmDCw1ooJh9jLdRjSq9J3nzZavEagJwWkA4eZOisCfcRr/1ymmMmbs7r2WmpwDwUuLD3FYgP7donZmikX4KgPUrJRoNaGJ04nPBq4h0D+nE42ETUiTJWl0w4uubgk9a3lHzePUvNahscb1ymTCX6ufvBTrKAp19mtiGbWuAeJioaGZc6puXTZQZpv12Zk9TpmcztI5jW1FWXSJN/vJwmvmKGFPbtD1GHLdr8bxCx3iFI7Ss56lAaHwgY2g3xaUfwy3FVX03mXJNLc+sGmW92pml3p60r1kGf2G0j13vMruOcutM13fLQ+sCmmg7D27lUpiKpPAUGHJOvJslrHfw4DH/F0FDYnQiN+Kyra8x3eo6+JbLJq+ALU8KkCSxrgnfclEVZvewj9gjpUrOzBG4SSRzrfy3CIO4TPcBNJIFT9L7VR16PmLRoV+7o5KbuRm3lJtT60wVUoEvegadzRWVXLfShVUuRQEKNtw5CdO4Y/tgT5O8xEuMZi9Hy+WMjptmZeBusn2ghVDFSAo0Qws210CpwVCM/VliIHjhby8SRDEwY7MCwWMRVDQSbeCI8SejHU+oSTHR77mkWDu5C54pVA==",
//      region: region,
//    );
    final signedRequest = new SigV4Request(
      awsSigV4Client,
      method: 'GET',
      path: path,
      // headers: new Map<String, String>.from({'header-1': 'one', 'header-2': 'two'}),
      // queryParams: new Map<String, String>.from({'tracking': 'x123'}),
      body: new Map<String, dynamic>.from(body),
    );

    http.Response response;

    response = await http.get(signedRequest.url, headers: signedRequest.headers);
    print(response.headers.toString());
    print(response.statusCode);
    return response;
  }
}