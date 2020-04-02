vcl 4.0;

backend default {
  # forward host settings
  .host = "nginx";
  .port = "80";
  # example
  # .host = "127.0.0.1";
  # .host = "www.example.com";

  # use https example
  # .port = "https";
  # .ssl = 1; # Turns on SSL support
  # .ssl_nosni = 0; # Disable SNI extension
  # .ssl_noverify = 1; # Don't verify peer
}

# キャッシュするか、しないかの設定
sub vcl_recv {
  # http methodのキャッシュ有無設定(POSTなどの登録系はキャッシュしない)
  if (req.method != "GET" && req.method != "HEAD") {
      return (pipe);
  }
  # Cookieと認証系のアクセスはキャッシュしない
  if (req.http.Cookie && req.http.Cookie ~ "authtoken=") {
      return (pipe);
  }
  if (req.http.Authenticate || req.http.Authorization) {
      return (pipe);
  }

  return (hash);
}

sub vcl_hash {
  hash_data(req.url);
  if (req.http.host) {
    hash_data(req.http.host);
  } else {
    hash_data(server.ip);
  }

  return (lookup);
}

sub vcl_backend_response {
  # cacheの生存時間設定
  set beresp.ttl = 24h;

  # 特定のリソースのみ別の時間を設定することも可能
  # if (bereq.url ~ "\.jpg$") {
  #   set beresp.ttl = 60s;
  # }

  return (deliver);
}