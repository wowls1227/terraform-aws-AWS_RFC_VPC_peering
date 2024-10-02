### VAULT
## vault hostname은 TFE에 private 네트워크 망이 연결된걸로 가정하고 지정 사용

# variable set
variable "vault_hostname" {
  default = ""
  description = "Vault Cluster의 hostname, Private url 사용"
}

# variable set
variable "admin_token" {
  default = ""
  description = "Vault의 관리자 TOKEN"
}


#required
variable "namespace_path" {
  # default = "prj1-other-region-namespace"
  description = "새로 생성할 vault namespace path"
}
# required
variable "entity_name" {
  # default = "admin-#123"
  description = "AD와 연동된 사용자 이메일 입력, vault에 client 사전생성용도"
}

### AWS 
###### DEST
# Vault Clutser를 사용할 과제 계정의 네트워크 자원 사용, Source의 TGW 와 연결됨

# required
variable "Project_Account_ID" {
  # default = "354918364637"
  description = "HPC와 연결할 Project Account의 ID 입력" 
}

# required
variable "dest_region" {
  # default = "ap-northeast-2"
  description = "HPC와 연결할 AWS VPC의 목적지 region을 입력"
}

# required
variable "dest_Access_key" {
  sensitive = true
  description = "HPC와 연결할 Project Account의 access key를 입력"
}

# required
variable "dest_Secret_key" {
  sensitive = true
  description = "HPC와 연결할 Project Account의 secret access key를 입력"
}
variable "dest_vpc_id" {
  # default = "vpc-014ca1f05f519b133"
  description = "HCP와 연결할 AWS VPC의 ID를 입력"
}

#### HCP

# variable set
variable "hcp_project_id" {
  default = ""
  description = "현재 Vault Cluster가 올라가있는 HCP Project ID"
}

# variable set
variable "hcp_client_id" {
  default   = ""
  sensitive = true
  description = "현재 Vault Cluster가 HCP Project의 Service Principal client ID"
}

# variable set
variable "hcp_client_secret" {
  default   = ""
  sensitive = true
  description = "현재 Vault Cluster가 HCP Project의 Service Principal client secret"
}

# variable set
variable "hvn_id" {
  default = ""
  description = "현재 Vault Cluster가 올라가있는 HCP HVN ID"
}

