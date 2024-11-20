variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "network_name" {
  description = "생성된 네트워크 이름"
  type        = string
}

variable "description" {
  type        = string
  description = "이 네트워크에 대한 설명"
  default     = ""
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "'default-route'와 'default-internet-gateway'가 삭제되어 있는지 확인 여부"
  default     = false
}

variable "mtu" {
  type        = number
  description = "네트워크 MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively."
  default     = 0
}

variable "subnets" {
  type        = list(map(string))
  description = "생성할 서브넷 목록"
}