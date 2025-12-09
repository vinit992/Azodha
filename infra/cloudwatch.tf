resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name = "predictor-high-cpu"
  namespace  = "AWS/EKS/ContainerInsights"
  metric_name="cpuUtilized"
  threshold = 80
  evaluation_periods = 2
  statistic="Average"
}

resource "aws_cloudwatch_metric_alarm" "mem" {
  alarm_name="predictor-high-memory"
  namespace="AWS/EKS/ContainerInsights"
  metric_name="memoryUtilized"
  threshold=80
  evaluation_periods = 2
}
