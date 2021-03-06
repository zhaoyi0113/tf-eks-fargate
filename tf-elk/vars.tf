variable "eks_cluster_name" {
  type    = string
  default = "elk"
}

variable "component_name" {
  type        = string
  description = "Component name"
  default     = "elk"
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "alb_endpoint" {
  type    = string
  default = "https://kibana.crms.myzeller.dev"
}

variable "api_gateway_endpoint" {
  type    = string
  default = "https://mx8eiab9ji.execute-api.ap-southeast-2.amazonaws.com/elk"
}

variable "fe_account_id" {
  type    = string
  default = "047535751763"
}

variable "fe_lambda_log_group_listener_role" {
  type    = string
  default = "arn:aws:iam::047535751763:role/tmpfe-cloudWatchListenerRole"
}
