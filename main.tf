terraform {
  required_providers {
    terratowns = {
        source = "local.providers/local/terratowns"
        version = "1.0.0"
    }
  }


  cloud {
    organization = "terraform-beginners-bootcamp"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
    endpoint = var.terratowns_endpoint
    user_uuid = var.teacherseat_user_uuid
    token = var.terratowns_access_token
}

module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.teacherseat_user_uuid
    index_html_filepath = var.index_html_filepath
    error_html_filepath = var.error_html_filepath
    content_version = var.content_version
    assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "My Love for Music"
  description = <<DESCRIPTION
I absolutely love music. In this page, I talk about music, why I like music, my favourite artists, and even 
link you to some of my favourite songs
  DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  # domain_name = "3fdq3gzzz.cloudfront.net"
  town = "gamers_grotto"
  content_version = 1
}

# module "terrahouse_aws" {
#     source = "./modules/terrahouse_aws"
#     user_uuid = var.teacherseat_user_uuid
#     index_html_filepath = var.index_html_filepath
#     error_html_filepath = var.error_html_filepath
#     content_version = var.content_version
#     assets_path = var.assets_path
# }

# resource "terratowns_home" "home" {
#   name = "Making Tandoori Chicken"
#   description = <<DESCRIPTION
# Tandoori chicken is amazing. 
#   DESCRIPTION
#   domain_name = module.terrahouse_aws.cloudfront_url
#   # domain_name = "3fdq3gzzz.cloudfront.net"
#   town = "melomaniac_mansion"
#   content_version = 1
# }