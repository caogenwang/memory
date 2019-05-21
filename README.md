# Memory

**TODO: Add description**

**创建的步骤**
 
mix new memory --umbrella
cd memory/apps/
mix phx.new.ecto redis
cd redis/
HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get
**mix.exs添加依赖(之前一直卡在了没有添加依赖:mariaex上，实例参考https://segmentfault.com/a/1190000005016957#articleHeader10)**
mix ecto.gen.migration add_file_metas -r Redis.Repo
mix ecto.migrate -r Redis.Repo


