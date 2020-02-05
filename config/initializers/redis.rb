REDIS_CONF = YAML.load_file(File.join(Rails.root, 'config/redis.yml'))[Rails.env]

$redis = Redis.new(host: REDIS_CONF['host'], port: REDIS_CONF['port'], url: REDIS_CONF['url'])
