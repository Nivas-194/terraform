resource "aws_elasticache_subnet_group" "redis_subnet" {
  name       = "redis-subnet"
  subnet_ids = [var.subnet_id]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id        = "redis"
  engine            = "redis"
  node_type         = "cache.t3.micro"
  num_cache_nodes   = 1
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet.name
  security_group_ids = [var.redis_sg]
}