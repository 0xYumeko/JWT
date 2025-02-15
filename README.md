<h1>JWT ATTACKS</h1>

![iwt](https://github.com/0x3f3c/JWT/assets/154844497/d4c5fed4-c3e2-4c61-8564-14e6dba097a4)


This code is a bash script that displays an ASCII art of a robot and defines a function to generate a JSON Web Token (JWT).

The ASCII art is displayed using echo command with escape sequences to change the text color to red. The art consists of a robot's head and upper body.

The generate_jwt function takes a single argument, payload, which is a JSON string containing the claims of the JWT. The function generates a JWT by encoding the payload using base64url encoding and concatenating it with a header and a signature. The header and signature are not implemented in this code snippet.

Here's a breakdown of the generate_jwt function:

The function takes a JSON string as an argument and assigns it to the payload variable.
The function creates a header JSON string with the algorithm set to HS256 and the type set to JWT.
The function encodes the header and payload using base64url encoding.
The function concatenates the encoded header, payload, and a signature (not implemented in this code snippet) with a . delimiter to form the JWT.
Note that this code snippet only implements the encoding of the header and payload, and does not include the generation of a signature, which is required for a valid JWT. Additionally, the base64url encoding used in this code snippet may not be secure enough for production use, and a more secure encoding method should be used instead.


```
./jwt.sh '{"user_id": 123, "username": "example_user"}' "your_secret_key" generate
```
```
./jwt.sh "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMjMsInVzZXJuYW1lIjoiZXhhbXBsZV91c2VyIn0" "your_secret_key" decode
```
![Screenshot from 2024-04-13 12-02-42](https://github.com/0x3f3c/JWT/assets/154844497/5689bb11-7891-4dbc-b0fc-8854b8d334c5)



