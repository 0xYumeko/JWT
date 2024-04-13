#!/bin/bash
echo -e "\033[31m
                   .;clc:,..                   
              'cx0XKKKK0Oxdl:;'.              
           'oKXKKKKXXXKXKK0Odocc:,.           
         .xXNXKXKKKXKK0XKXKO0dolccc,          
        cNWNNNN0KKN00kXOXKKkKdOldccc:.        
      .xNNXXXN0NkWX0KONON0KxNx0oxkcclc.   ... 
    .cONNKK0XkNkONkkk0K0N0kxXo0dxkk:llc ....  
    ,kX0O0kKoX0cXkcO:KkKNOoO0ooxxoOl:c' ....  
   :xxOOKxXddXd:Xc:dcKl0KdcOcx:xdold:c. ...   
      lKOxOldO:okco:ox;kxcdc:o,dlx;o:c' ...   
     :KOxdk::c,,.'lc0o:lo:c::c,lco;:cc;. ..   
     kc'klkl;cdkl:;oOdc;c;;',,c:c:;;c:,;.     
    .  ,':oOodXNNNNNNXkKx:...l,',;,c:,:'.     
        ;c:;cl0WWWWWWWNXNXK00xl:c'c:;' :      
       ..:c::xXWXWWWWNx0NNXXKxo,: ;:.         
       .:ccc::0WN0NWWNXXNXXKko;'              
            . ;dXNKXK00XK0xl..:;'.            
              .dlxKX0Oxc;',x0XXX0Od.          
              .',,,,,..  dNWWWWNX0ko          
           .:kNOc ....:.oWWMMMWWNKOx.         
  ,cdxxkO0KNKK0d.cdxOXc,XWWWMMMWNXOxc         
oWMMMMMMWWNNNXd.lKNNNo;cWWWKWMWWNX0xo         
cKMMWMMMWWNNXk.,KNWK::;:NNNkNWWWNX0kd.
\033[0m"

generate_jwt() {
    local payload="$1"
    local secret_key="$2"
    local expiration_time=$(date -d "+1 hour" +%s)
    local header='{"alg": "HS256", "typ": "JWT"}'
    local encoded_header=$(echo -n "$header" | base64 | tr -d '=' | tr '/+' '_-')

    local encoded_payload=$(echo -n "$payload" | base64 | tr -d '=' | tr '/+' '_-')

    local unsigned_token="$encoded_header.$encoded_payload"
    local signature=$(echo -n "$unsigned_token" | openssl dgst -binary -sha256 -hmac "$secret_key" | base64 | tr -d '=' | tr '/+' '_-')

    local jwt_token="$unsigned_token.$signature"

    echo "$jwt_token"
}

decode_and_verify_jwt() {
    local token="$1"
    local secret_key="$2"

    IFS='.' read -r -a parts <<< "$token"
    local encoded_header="${parts[0]}"
    local encoded_payload="${parts[1]}"
    local signature="${parts[2]}"

    local header=$(echo -n "$encoded_header" | base64 -d)
    local payload=$(echo -n "$encoded_payload" | base64 -d)

    local unsigned_token="$encoded_header.$encoded_payload"
    local calculated_signature=$(echo -n "$unsigned_token" | openssl dgst -binary -sha256 -hmac "$secret_key" | base64 | tr -d '=' | tr '/+' '_-')

    if [ "$calculated_signature" == "$signature" ]; then
        echo "Decoded Payload: $payload"
    else
        echo "Invalid token."
    fi
}

if [ $# -ne 3 ]; then
    echo "Usage: $0 <payload> <secret_key> <operation>"
    exit 1
fi

payload="$1"
secret_key="$2"
operation="$3"

if [ "$operation" == "generate" ]; then
    jwt_token=$(generate_jwt "$payload" "$secret_key")
    echo "Generated JWT token  :  $jwt_token "
elif [ "$operation" == "decode" ]; then
    decode_and_verify_jwt "$payload" "$secret_key"
else
    echo "Invalid operation. Use 'generate' or 'decode'."
fi



#HelltakerC3rb