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
运行时增加变量的方法
SERVER_NAME=yansen_cache ENV mix phx.server 

**redis的相关配置步骤**
1、首先创建conf的相关文件夹，将conf文件根据需求修改，然后放入到对应的文件夹下
2、一次运行各个启动脚本即可.
3、从服务器配置的主服务器的ip是docker的地址，如果在同一个网段内是可以直接通信的；但如果不是同一网段内，可能需要
    配置网桥连接，没试过。
**遇到的问题**
1、启动了一个哨兵，但是投票权却配置的2，导致不切换

**整体架构**
        采用1+2，一主两从模式，因此先配置一主两从;读写分离，主备切换，因为一个sentinel可以监控多个，所以可以让一个sentinel去监控三个运行的redis服务器，注意要写docker的地址。
                ---------
               |  Client |
                ---------
           (R) /    |(W)  \ (R)
              / ---------  \                   ----------
            /  |  master |--\-----------------| sentinel |(monitor)
           /    ---------    \                 ----------
          /    /        \     \             
         /    /          \     \          
        /    /            \     \      
     --------              --------  
    | slave1 |            | slave1 |           
     --------              --------   
1、client在发起连接之前去获取读或者写服务器的url，然后决定往哪个服务器写或者从哪个服务器读数据。
2、所有的set，del操作去获取master地址，所有的get去获取slave的地址。