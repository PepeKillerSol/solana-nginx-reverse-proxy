# solana-nginx-reverse-proxy

Secure ssl proxy with IP rate limiting between nginx running on your server and a quicknode solana rpc endpoint.

Make sure you set up a proper zone in the `http{}` block of `nginx.conf`.
