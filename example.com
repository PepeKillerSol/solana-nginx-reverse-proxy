upstream quiknode {
	server <RCP DOMAIN>;
}

server {
	server_name <SERVER URL>;

	access_log /var/log/nginx/quiknode.access.log;
	location / {
		limit_req zone=<ZONE NAME>;
		proxy_pass http://quiknode/<QUICKNODE API KEY>/;
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme; 
	}
	listen 443 ssl;
	# add ssl certs below
}

server {
	if ($host = <SERVER URL>) {
		return 301 https://$host$request_uri;
	}

	server_name <SERVER URL>;
	listen 80;
	return 404;
}
